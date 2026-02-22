<p align="center">
	<img src="logo.png" width="40%" alt="DLDFoundation Logo" />
</p>

<p align="center">
	<!--<a href="https://swiftpackageindex.com/diliedevs/DLDFoundation">
		<img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdiliedevs%2FDLDFoundation%2Fbadge%3Ftype%3Dswift-versions" alt="Swift versions" />
	</a>
	<a href="https://swiftpackageindex.com/diliedevs/DLDFoundation">
		<img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdiliedevs%2FDLDFoundation%2Fbadge%3Ftype%3Dplatforms" alt="Swift versions" />
	</a>-->
	<a href="https://github.com/diliedevs/DLDFoundation">
		<img src="https://img.shields.io/badge/Swift-6.2-F05138?logo=swift" alt="Swift Version">
	</a>
	<a href="https://github.com/diliedevs/DLDFoundation">
		<img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-0D96F6?logo=apple" alt="Apple Platforms">
	</a>
	<a href="https://github.com/diliedevs/DLDFoundation/tags">
		<img src="https://img.shields.io/github/v/tag/diliedevs/DLDFoundation" alt="Current Tag" />
	</a>
	<a href="https://github.com/diliedevs/DLDFoundation/blob/main/LICENSE">
		<img src="https://img.shields.io/github/license/diliedevs/DLDFoundation?logo=license" alt="License type" />
	</a>
	<a href="https://twitter.com/DiLieDevs">
		<img src="https://img.shields.io/badge/@DiLieDevs-black?logo=x" alt="@DiLieDevs on X" />
	</a>
</p>

# DLDFoundation

`DLDFoundation` is a utility Swift package with focused `Foundation` and standard-library extensions for day-to-day app development.

It includes helpers for:

- Date and time calculations
- JSON encoding/decoding
- URL and file-system scanning
- String transformations and casing
- Collection sorting/grouping utilities
- Numeric conversions and convenience operations
- Bundle/Info.plist accessors

## Requirements

- Swift `6.2` (`swift-tools-version: 6.2`)
- macOS `14+`
- iOS `17+`

## Dependencies

- [`CaseAnything`](https://github.com/mesqueeb/CaseAnything) (used by string casing helpers)

## Installation

Add the package in Xcode (`File > Add Package Dependencies...`) or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/diliedevs/DLDFoundation.git", branch: "main")
]
```

Then add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "DLDFoundation", package: "DLDFoundation")
    ]
)
```

Import it where needed:

```swift
import DLDFoundation
```

## Highlights

### Date and Time

```swift
let now = Date.now

let startOfMonth = now.start(of: .month)
let endOfWeek = now.end(of: .week)
let nextDay = now.next(unit: .day)

let hoursUntilTomorrow = now.preciseCount(of: .hour, toDate: nextDay)
let changedYear = now.changing([.year: 2030])

let oneAndHalfDays = 36.hours.count(unit: .day) // 1.5
```

### JSON

```swift
struct Payload: Codable {
    let id: Int
    let title: String
}

let payload = Payload(id: 1, title: "Hello")

let data = try Data.encodedJSON(
    payload,
    using: JSONEncoder(prettyPrinted: true, sortedKeys: true)
)

let decoded: Payload = try data.decodeJSON()
```

### URLs and File System

```swift
let root = URL(filePath: "/Users/me/Documents")

if root.exists, root.isDirectory {
    let shallow = try root.quickScan(includeHidden: false)
    let deep = try root.recursiveScan(relativeURLs: false, includeHidden: true)
    print(shallow.count, deep.count)
}
```

### Query Items

```swift
let items = [URLQueryItem]([
    "q": "swift",
    "page": 1
])

let sorted = items.sortedByName()
let query = sorted["q"] // "swift"
```

### Collections

```swift
struct User {
    let id: Int
    let name: String
}

let users = [
    User(id: 2, name: "B"),
    User(id: 1, name: "A")
]

let sorted = users.sorted(by: \.id)
let grouped = users.grouped(by: \.name)

let values = [1, 2, 2, 3].uniqued() // order is not guaranteed
```

### Strings

```swift
let title = "hello world"

title.camelCased()     // "helloWorld"
title.pascalCased()    // "HelloWorld"
title.kebabCased()     // "hello-world"
title.snakeCased()     // "hello_world"
title.constantCased()  // "HELLO_WORLD"
```

## API Surface (By Area)

- `Date`, `TimeInterval`, `Calendar.Component` (`CalUnit`), `Locale`
- `URL`, `URLComponents`, `URLQueryItem`, `FileManager`
- `String`
- `Sequence`, `Collection`, `Array`, `Set`, `Dictionary`
- `BinaryInteger`, `BinaryFloatingPoint`, `Numeric`, `Bool`
- `Optional`, `Comparable`, `Bundle`
- `JSONEncoder`, `JSONDecoder`, `Data`
- `NSSortDescriptor` (`Sorter` typealias)
- Model aliases: `Model`, `ModelEnum`

## Testing

Run the test suite:

```bash
swift test
```

Current tests cover JSON helpers, URL/file scanning helpers, and date calculations.

## License
DLDFoundation is available under the MIT license, which permits commercial use, modification, distribution, and private use. See the [LICENSE](https://github.com/diliedevs/DLDFoundation/blob/main/LICENSE) file for more info.
