//
//  URLHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension URL {
    
    // MARK: - Getting System Directory URLs
    /// Returns the URL for the home directory of the current user.
    static var home: URL {
        return URL(filePath: FilePath.home)
    }
    /// Returns the URL for the desktop directory of the current user.
    static var desktop: URL {
        return Filer.shared.userURL(for: .desktopDirectory)
    }
    /// Returns the URL for the documents directory of the current user.
    static var documents: URL {
        return Filer.shared.userURL(for: .documentDirectory)
    }
    /// Returns the URL for the downloads directory of the current user.
    static var downloads: URL {
        return Filer.shared.userURL(for: .downloadsDirectory)
    }
    /// Returns the URL for the application support directory for all applications of the current user.
    static var appSupport: URL {
        return Filer.shared.userURL(for: .applicationSupportDirectory)
    }
    /// Returns the URL for the application support directory for the application of the current user.
    static var appSupportDocs: URL {
        let asd = appSupport.appendingPathComponent(Bundle.main.name, isDirectory: true)
        Filer.shared.createDirectory(at: asd)
        
        return asd
    }
    /// Returns the URL for the local trash directory.
    @available(iOS 11.0, OSX 10.0, *)
    static var trash: URL {
        return Filer.shared.localURL(for: .trashDirectory)
    }
    /// Returns the URL for the local applications directory.
    static var applications: URL {
        return Filer.shared.localURL(for: .applicationDirectory)
    }
    
    // MARK: - URL Properties
    //******************************************************************************************************//
    
    /// Returns `true` if the URL path represents a directory.
    var isDirectory: Bool {
        return pathExtension.isEmpty
    }
    /// Returns `true` if the URL path represents a file.
    var isFile: Bool {
        return isDirectory == false
    }
    var exists: Bool {
        return Filer.shared.fileExists(atPath: path)
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
    
    var data: Data? { try? Data(contentsOf: self) }
    
    // MARK: - Creating URLs
    /// Creates a file URL with the specified path.
    /// - Parameter filePath: The path to the file for which to create a URL.
    init(filePath: FilePath) {
        self.init(fileURLWithPath: filePath.fullUserPath)
    }
    
    /// Returns a new URL by appending the string to the right of the plus sign to the url on the left.
    /// - Parameters:
    ///   - lhs: The URL to append the string path component to.
    ///   - rhs: A string representing a path component to append to the URL.
    static func + (lhs: URL, rhs: String) -> URL {
        lhs.appendingPathComponent(rhs)
    }
    
    // MARK: - Reading and Writing Text
    func readText() -> String? {
        try? String(contentsOf: self)
    }
    func saveText(_ text: String, atomically: Bool = true, encoding: String.Encoding = .utf8) {
        try? text.write(to: self, atomically: atomically, encoding: encoding)
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
    @available(OSX 10.11, iOS 9.0, *)
    func contentsOfDirectory(deepEnumeration deep: Bool, relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [URL] {
        guard isDirectory else { return [] }
        
        return try Filer.shared.contentsOfDirectory(at: self, deepEnumeration: deep, relativeURLs: relativeURLs, includeHidden: includeHidden, includePackageContents: includePackageContents)
    }
    @available(OSX 10.11, iOS 9.0, *)
    func quickScan(includeHidden: Bool = false) throws -> [URL] {
        try Filer.shared.quickScan(url: self, includeHidden: includeHidden)
    }
    @available(OSX 10.11, iOS 9.0, *)
    func recursiveScan(relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [URL] {
        try contentsOfDirectory(deepEnumeration: true, relativeURLs: relativeURLs, includeHidden: includeHidden, includePackageContents: includePackageContents)
    }
}
