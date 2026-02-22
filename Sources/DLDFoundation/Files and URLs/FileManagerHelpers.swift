//
//  FileManagerHelpers.swift
//  DLDFoundation
//

import Foundation

public extension FileManager {
    /// Performs a shallow directory scan.
    func quickScan(url: URL, includeHidden: Bool = false) throws -> [URL] {
        guard url.isDirectory else { return [] }

        var options: FileManager.DirectoryEnumerationOptions = []
        if includeHidden == false {
            options.insert(.skipsHiddenFiles)
        }

        return try contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: options
        )
    }

    /// Performs either a shallow or deep directory scan.
    func contentsOfDirectory(
        at directoryURL: URL,
        deepEnumeration deep: Bool,
        relativeURLs: Bool = true,
        includeHidden: Bool = false,
        includePackageContents: Bool = false
    ) throws -> [URL] {
        let scannedURLs: [URL]

        if deep {
            var options: FileManager.DirectoryEnumerationOptions = []
            if includeHidden == false {
                options.insert(.skipsHiddenFiles)
            }
            if includePackageContents == false {
                options.insert(.skipsPackageDescendants)
            }

            guard let enumerator = enumerator(
                at: directoryURL,
                includingPropertiesForKeys: [.isDirectoryKey],
                options: options
            ) else {
                return []
            }

            scannedURLs = enumerator.compactMap { $0 as? URL }
        } else {
            scannedURLs = try quickScan(url: directoryURL, includeHidden: includeHidden)
        }

        guard relativeURLs else {
            return scannedURLs
        }

        let basePath = directoryURL.standardizedFileURL.path(percentEncoded: false)
        let basePrefix = basePath.hasSuffix("/") ? basePath : basePath + "/"

        return scannedURLs.map { itemURL in
            let fullPath = itemURL.standardizedFileURL.path(percentEncoded: false)
            guard fullPath.hasPrefix(basePrefix) else {
                return itemURL
            }

            let relativePath = String(fullPath.dropFirst(basePrefix.count))
            return URL(
                filePath: relativePath,
                directoryHint: itemURL.hasDirectoryPath ? .isDirectory : .notDirectory,
                relativeTo: directoryURL.standardizedFileURL
            )
        }
    }
}
