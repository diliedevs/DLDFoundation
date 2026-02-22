//
//  URLHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension URL {
    // MARK: - URL Properties

    /// Returns `true` if the URL path represents a directory.
    var isDirectory: Bool {
        let values = try? resourceValues(forKeys: [.isDirectoryKey])
        return values?.isDirectory ?? hasDirectoryPath
    }
    /// Returns `true` if the URL path represents a file.
    var isFile: Bool {
        return isDirectory == false
    }
    var exists: Bool {
        return (try? checkResourceIsReachable()) ?? false
    }
    /// Returns the URL for the parent directory.
    var directoryURL: URL {
        return deletingLastPathComponent()
    }
    /// Returns the URL without the path extension.
    var withoutExtension: URL {
        return deletingPathExtension()
    }
    /// Returns the name of the file at the receiver's URL with the path extension.
    var filename: String {
        return lastPathComponent
    }
    /// Returns the name of the file at the receiver's URL without the path extension.
    var name: String {
        return withoutExtension.lastPathComponent
    }

    // MARK: - Creating URLs
    /// Returns a new URL by appending the string to the right of the plus sign to the URL on the left.
    static func + (lhs: URL, rhs: String) -> URL {
        lhs.appendingPathComponent(rhs)
    }
    
    // MARK: - Getting URL Contents
    /// Returns the data contents of the file at the receiving URL, if there is any.
    var data: Data? {
        try? Data(contentsOf: self)
    }
    
    /// Returns the string contents of the file at the receiving URL, if there is any.
    var string: String? {
        try? String(contentsOf: self)
    }
    
    // MARK: - Discovering Directory Contents
    /// Performs a search of the receiving directory url and returns the urls for any contained items.
    ///
    /// - parameter deep: Set to `true` to perform a deep enumeration descending into subdirectories and packages.
    /// - parameter relativeURLs: Set to `false` to return full path URLs. Default is set to `true`, returning relative path URLs.
    /// - parameter includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    /// - parameter includePackageContents: Set to `true` to include package contents in the result. Default is set to `false`, skipping package descendants, treating packages like files.
    ///
    /// - returns: An array of urls for the contents of the specified directory.
    func contentsOfDirectory(deepEnumeration deep: Bool, relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [URL] {
        guard isDirectory else { return [] }

        return try FileManager
            .default.contentsOfDirectory(
                at: self,
                deepEnumeration: deep,
                relativeURLs: relativeURLs,
                includeHidden: includeHidden,
                includePackageContents: includePackageContents
            )
    }
    /// Performs a shallow search of the receiving directory URL and returns the URLs for any contained items.
    /// - Parameters:
    ///   - includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    /// - Returns: An array of URLs for the contents of the receiving directory URL.
    func quickScan(includeHidden: Bool = false) throws -> [URL] {
        try FileManager.default.quickScan(url: self, includeHidden: includeHidden)
    }
    /// Performs a deep search of the receiving directory URL and returns the URLs for any contained items.
    /// - Parameters:
    ///   - relativeURLs: Set to `false` to return full path URLs. Default is set to `true`, returning relative path URLs.
    ///   - includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    ///   - includePackageContents: Set to `true` to include package contents in the result. Default is set to `false`, skipping package descendants, treating packages like files.
    /// - Returns: An array of URLs for the contents of the receiving directory URL.
    func recursiveScan(relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [URL] {
        try contentsOfDirectory(deepEnumeration: true, relativeURLs: relativeURLs, includeHidden: includeHidden, includePackageContents: includePackageContents)
    }
}

public extension URLComponents {
    init?(url: URL?, queryItems: [URLQueryItem]?) {
        guard let url = url else { return nil }
        
        self.init(url: url, resolvingAgainstBaseURL: true)
        self.queryItems = queryItems
    }
}
