//
//  FilePath.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `String` to easily work with file paths.
public typealias FilePath = String

public extension FilePath {
    /// Returns the path for the home directory of the current user.
    static var home: FilePath {
        return ProcessInfo.processInfo.environment["HOME"]!
    }
    /// A representation of the path that replaces the current home directory portion of the current path with a tilde `~` character.
    var shortUserPath: FilePath {
        return hasPrefix(Self.home) ? "~" + dropFirst(Self.home.count) : self
    }
    /// A representation of the path made by expanding the initial component of the receiver to its full path value.
    var fullUserPath: FilePath {
        return hasPrefix("~") ? Self.home + dropFirst() : self
    }
    /// Returns the file url of the fully expanded path.
    var fileURL: URL {
        return URL(filePath: self.fullUserPath)
    }
    /// Returns a Boolean value that indicates whether a file or directory exists at the specified path.
    var exists: Bool {
        return Filer.shared.fileExists(atPath: fullUserPath)
    }
    /// Returns `true` if the receiving path represents a folder or directory.
    var isFolder: Bool {
        fileURL.isDirectory
    }
    /// Returns `true` if the receiving path represents a file.
    var isFile: Bool {
        return isFolder == false
    }
    /// The file-system path components of the receiver.
    var pathComponents: [String] {
        return fileURL.pathComponents
    }
    /// A representation of the path made by deleting the last path component from the receiver, along with any final path separator.
    var directoryPath: FilePath {
        return fileURL.directoryURL.path
    }
    /// The last component of the path.
    var lastPathComponent: FilePath {
        return fileURL.lastPathComponent
    }
    /// The path extension, if any, of the path .
    var pathExtension: FilePath {
        return fileURL.pathExtension
    }
    /// A representation of the path made by deleting the extension (if any, and only the last) from the receiver.
    var withoutExtension: FilePath {
        return fileURL.withoutExtension.path
    }
    /// Returns the name of the file at the receiver path with the path extension.
    var filename: String {
        return fileURL.filename
    }
    /// Returns the name of the file at the receiver path without the path extension.
    var name: String {
        return fileURL.name
    }
    
    // MARK: - Creating File Paths
    /// Returns a new path made by appending a given path to the receiver.
    ///
    /// - Parameter component: The path component to append to the receiver.
    /// - Returns: A new path made by appending `component` to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ component: String) -> FilePath {
        return fileURL.appendingPathComponent(component).path
    }
    
    // MARK: - Deleting Files
    /// Permanently removes, i.e. deletes, the file or directory at the receiver's path from the system.
    func remove() throws {
        try Filer.shared.removeFile(at: fileURL)
    }
    
    /// Moves the file or directory at the receiver's path to the trash.
    @available(iOS 11.0, *)
    func trash() throws {
        try Filer.shared.trashFile(at: fileURL)
    }
    
    // MARK: - Moving and Copying Files
    func move(toDirectory directory: URL, preferredName: String = "", then handleDestination: ((FilePath) -> Void) = { _ in }) throws {
        try Filer.shared.moveFile(at: fileURL, to: directory, preferredName: preferredName, then: { url in
            handleDestination(url.path)
        })
    }
    
    func copy(toDirectory directory: URL, preferredName: String = "", then handleDestination: ((FilePath) -> Void) = { _ in }) throws {
        try Filer.shared.copyFile(at: fileURL, to: directory, preferredName: preferredName, then: { url in
            handleDestination(url.path)
        })
    }
    
    // MARK: - Discovering Directory Contents
    
    /// Performs a search of the receiving directory path and returns the file paths for any contained items.
    ///
    /// - parameter deep: Set to `true` to perform a deep enumeration descending into subdirectories and packages.
    /// - parameter relativeURLs: Set to `false` to return full paths. Default is set to `true`, returning relative paths.
    /// - parameter includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    /// - parameter includePackageContents: Set to `true` to include package contents in the result. Default is set to `false`, skipping package descendants, treating packages like files.
    ///
    /// - returns: An array of file paths for the contents of the specified directory.
    @available(OSX 10.11, iOS 9.0, *)
    func contentsOfDirectory(deepEnumeration deep: Bool, relativePaths: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [FilePath] {
        guard isFolder else { return [] }

        let urls = try Filer.shared.contentsOfDirectory(at: fileURL, deepEnumeration: deep, relativeURLs: relativePaths, includeHidden: includeHidden, includePackageContents: includePackageContents)
        return urls.map { relativePaths ? $0.relativePath : $0.path }
    }
    
    @available(OSX 10.11, iOS 9.0, *)
    func quickScan(includeHidden: Bool = false) throws -> [FilePath] {
        guard isFolder else { return [] }
        
        let urls = try Filer.shared.quickScan(url: fileURL, includeHidden: includeHidden)
        return urls.map(\.path)
    }
    @available(OSX 10.11, iOS 9.0, *)
    func recursiveScan(relativePaths: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [FilePath] {
        return try contentsOfDirectory(deepEnumeration: true, relativePaths: relativePaths, includeHidden: includeHidden, includePackageContents: includePackageContents)
    }
}
