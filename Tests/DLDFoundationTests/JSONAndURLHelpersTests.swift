import Foundation
import Testing
@testable import DLDFoundation

@Suite("JSON Helpers")
struct JSONHelpersTests {
    private struct Payload: Codable, Equatable, Sendable {
        let id: Int
        let title: String
        let tags: [String]
    }

    @Test("encodedJSON and decodeJSON round-trip")
    func encodeDecodeRoundTrip() throws {
        let payload = Payload(id: 7, title: "DLD", tags: ["swift", "testing"])
        let encoder = JSONEncoder(prettyPrinted: false, sortedKeys: true)

        let data = try Data.encodedJSON(payload, using: encoder)
        let decoded: Payload = try data.decodeJSON()

        #expect(decoded == payload)
    }

    @Test("decodeJSON throws for malformed payload")
    func decodeJSONThrowsForInvalidData() throws {
        let data = Data("{}".utf8)

        #expect(throws: DecodingError.self) {
            let _: Payload = try data.decodeJSON()
        }
    }

    @Test("concurrent decoding is deterministic")
    func concurrentDecodeIsDeterministic() async throws {
        let payload = Payload(id: 99, title: "Async", tags: ["stable", "fast"])
        let data = try Data.encodedJSON(payload, using: JSONEncoder(prettyPrinted: false, sortedKeys: true))
        let iterations = 24

        let decodedValues = try await withThrowingTaskGroup(of: Payload.self, returning: [Payload].self) { group in
            for _ in 0..<iterations {
                group.addTask {
                    try data.decodeJSON(Payload.self)
                }
            }

            return try await group.reduce(into: [Payload]()) { partialResult, value in
                partialResult.append(value)
            }
        }

        #expect(decodedValues.count == iterations)
        #expect(decodedValues.allSatisfy { $0 == payload })
    }
}

@Suite("URL Helpers")
struct URLHelpersTests {
    @Test("URL metadata and file contents are exposed correctly")
    func urlMetadataAndContents() throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let alphaFile = root.appending(path: "alpha.txt")
        let subdirectory = root.appending(path: "sub", directoryHint: .isDirectory)

        #expect(root.exists)
        #expect(root.isDirectory)
        #expect(root.isFile == false)
        #expect(alphaFile.exists)
        #expect(alphaFile.isFile)
        #expect(alphaFile.isDirectory == false)
        #expect(alphaFile.filename == "alpha.txt")
        #expect(alphaFile.name == "alpha")
        #expect(alphaFile.withoutExtension.lastPathComponent == "alpha")
        #expect(alphaFile.directoryURL == root)
        #expect(alphaFile.string == "alpha")
        #expect(alphaFile.data == Data("alpha".utf8))
        #expect(subdirectory.isDirectory)
    }

    @Test("quickScan and recursiveScan respect hidden file filtering")
    func scanHiddenFiltering() throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let shallowVisible = try root.quickScan(includeHidden: false).map(\.lastPathComponent).sorted()
        let shallowAll = try root.quickScan(includeHidden: true).map(\.lastPathComponent).sorted()

        #expect(shallowVisible == ["alpha.txt", "sub"])
        #expect(shallowAll == [".hidden.txt", "alpha.txt", "sub"])

        let deepVisible = try root.recursiveScan(relativeURLs: false, includeHidden: false)
        let deepAll = try root.recursiveScan(relativeURLs: false, includeHidden: true)

        let visiblePaths = relativePaths(from: deepVisible, base: root)
        let allPaths = relativePaths(from: deepAll, base: root)

        #expect(visiblePaths == ["alpha.txt", "sub", "sub/nested.txt"])
        #expect(allPaths == [".hidden.txt", "alpha.txt", "sub", "sub/nested.txt"])
    }

    @Test("scanning a file URL returns no directory contents")
    func nonDirectoryScanIsEmpty() throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let alphaFile = root.appending(path: "alpha.txt")
        let entries = try alphaFile.contentsOfDirectory(deepEnumeration: true)

        #expect(entries.isEmpty)
    }

    @Test("quickScan on a file URL returns an empty list")
    func quickScanOnFileIsEmpty() throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let alphaFile = root.appending(path: "alpha.txt")
        let entries = try alphaFile.quickScan(includeHidden: true)

        #expect(entries.isEmpty)
    }

    @Test("concurrent recursive scans are deterministic")
    func concurrentRecursiveScanIsDeterministic() async throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let iterations = 20
        let expected = [".hidden.txt", "alpha.txt", "sub", "sub/nested.txt"]

        let snapshots = try await withThrowingTaskGroup(of: [String].self, returning: [[String]].self) { group in
            for _ in 0..<iterations {
                group.addTask {
                    let deepAll = try root.recursiveScan(relativeURLs: false, includeHidden: true)
                    return relativePaths(from: deepAll, base: root)
                }
            }

            return try await group.reduce(into: [[String]]()) { partialResult, value in
                partialResult.append(value)
            }
        }

        #expect(snapshots.count == iterations)
        #expect(snapshots.allSatisfy { $0 == expected })
    }

    @Test("URLComponents convenience initializer handles nil URL")
    func urlComponentsInitializerBehavior() {
        let queryItems = [URLQueryItem(name: "q", value: "swift")]

        #expect(URLComponents(url: nil, queryItems: queryItems) == nil)

        let baseURL = URL(string: "https://example.com/search")
        let components = URLComponents(url: baseURL, queryItems: queryItems)

        #expect(components?.queryItems == queryItems)
    }

    @Test("relative recursive scans keep the scanned directory as base URL")
    func relativeRecursiveScanUsesDirectoryBase() throws {
        let root = try makeFixtureDirectory()
        defer { try? FileManager.default.removeItem(at: root) }

        let relativeURLs = try root.recursiveScan(relativeURLs: true, includeHidden: false)
        let relativePaths = relativeURLs.map(\.relativePath).sorted()

        #expect(relativePaths == ["alpha.txt", "sub", "sub/nested.txt"])
        #expect(relativeURLs.allSatisfy { $0.baseURL?.standardizedFileURL == root.standardizedFileURL })
    }
}

@Suite("Date Helpers")
struct DateHelpersTests {
    @Test("precise day counts keep fractional values")
    func preciseCountKeepsFractionalDays() {
        let start = Date(timeIntervalSince1970: 0)
        let end = start + 36.hours

        let preciseDayCount = start.preciseCount(of: .day, toDate: end)
        let wholeDayCount = start.count(of: .day, toDate: end)

        #expect(abs(preciseDayCount - 1.5) < 0.0001)
        #expect(wholeDayCount == 1)
    }

    @Test("precise month and year counts follow calendar boundaries")
    func preciseMonthAndYearCountsUseCalendarUnits() throws {
        let calendar = Calendar.autoupdatingCurrent
        let start = try #require(calendar.date(from: DateComponents(year: 2024, month: 2, day: 1, hour: 12)))
        let oneMonthLater = try #require(calendar.date(from: DateComponents(year: 2024, month: 3, day: 1, hour: 12)))
        let oneYearLater = try #require(calendar.date(from: DateComponents(year: 2025, month: 2, day: 1, hour: 12)))

        #expect(start.preciseCount(of: .month, toDate: oneMonthLater) == 1)
        #expect(start.preciseCount(of: .year, toDate: oneYearLater) == 1)
    }

    @Test("changing year updates year component")
    func changingYearUpdatesYear() throws {
        let calendar = Calendar.autoupdatingCurrent
        let juneDate = try #require(calendar.date(from: DateComponents(year: 2021, month: 6, day: 15, hour: 12)))
        let newYearDate = try #require(calendar.date(from: DateComponents(year: 2021, month: 1, day: 1, hour: 12)))

        let juneUpdated = juneDate.changing([.year: 2020])
        let newYearUpdated = newYearDate.changing([.year: 2020])

        #expect(juneUpdated.year == 2020)
        #expect(juneUpdated.month == juneDate.month)
        #expect(juneUpdated.day == juneDate.day)

        #expect(newYearUpdated.year == 2020)
        #expect(newYearUpdated.month == newYearDate.month)
        #expect(newYearUpdated.day == newYearDate.day)
    }
}

private func makeFixtureDirectory() throws -> URL {
    let root = FileManager.default.temporaryDirectory.appending(path: "DLDFoundationTests-\(UUID().uuidString)", directoryHint: .isDirectory)
    let subdirectory = root.appending(path: "sub", directoryHint: .isDirectory)

    try FileManager.default.createDirectory(at: subdirectory, withIntermediateDirectories: true)
    try "alpha".write(to: root.appending(path: "alpha.txt"), atomically: true, encoding: .utf8)
    try "hidden".write(to: root.appending(path: ".hidden.txt"), atomically: true, encoding: .utf8)
    try "nested".write(to: subdirectory.appending(path: "nested.txt"), atomically: true, encoding: .utf8)

    return root
}

private func relativePaths(from urls: [URL], base: URL) -> [String] {
    let basePath = base.standardizedFileURL.resolvingSymlinksInPath().path(percentEncoded: false)
    let basePrefix = basePath.hasSuffix("/") ? basePath : basePath.appending("/")

    return urls.map { url in
        let absolutePath = url.standardizedFileURL.resolvingSymlinksInPath().path(percentEncoded: false)
        guard absolutePath.hasPrefix(basePrefix) else {
            return absolutePath
        }

        var relative = String(absolutePath.dropFirst(basePrefix.count))
        if relative.hasSuffix("/") {
            relative.removeLast()
        }

        return relative
    }
    .sorted()
}
