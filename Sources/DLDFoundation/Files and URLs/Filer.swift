//
//  Filer.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/**
 A `Filer` object lets you examine the contents of the file system and make changes to it. It is a more convenient way to interact with the file system through the `Filemanager` class.
 */
public class Filer : FileManager {
    
    // MARK: - Creating a Filer Object
    /// Returns an initialized `Filer` instance.
    ///
    /// - returns: An initialized `Filer` instance.
    override init() { super.init() }
    
    /// The shared `Filer` object.
    public static let shared = Filer()
    
    // MARK: - Locating System Directories
    /// Returns the URL of the specified system directory in the `User` domain.
    ///
    /// - parameter directory: The desired system directory in the `User` domain.
    ///
    /// - returns: The URL of the specified system directory in the `User` domain.
    public func userURL(for directory: SearchPathDirectory) -> URL {
        return urls(for: directory, in: .userDomainMask)[0]
    }
    /// Returns the URL of the specified system directory in the `Local` domain.
    ///
    /// - parameter directory: The desired system directory in the `Local` domain.
    ///
    /// - returns: The URL of the specified system directory in the `Local` domain.
    public func localURL(for directory: SearchPathDirectory) -> URL {
        return urls(for: directory, in: .localDomainMask)[0]
    }
    
    // MARK: - Discovering Directory Contents
    /// Returns a Boolean value that indicates whether a file or directory exists at a specified URL.
    /// - Parameter url: The URL of the file or directory.
    public func fileExists(at url: URL) -> Bool {
        fileExists(atPath: url.path)
    }
    /// Performs a search of the specified directory URL and returns the URLs for any contained items.
    ///
    /// - parameter url: The URL of the directory whose contents you want to enumerate.
    /// - parameter deep: Set to `true` to perform a deep enumeration descending into subdirectories and packages.
    /// - parameter relativeURLs: Set to `false` to return full path URLs. Default is set to `true`, returning relative path URLs.
    /// - parameter includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    /// - parameter includePackageContents: Set to `true` to include package contents in the result. Default is set to `false`, skipping package descendants, treating packages like files.
    ///
    /// - returns: An array of URLs for the contents of the specified directory.
    public func contentsOfDirectory(at url: URL, deepEnumeration deep: Bool, relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws -> [URL] {
        guard url.isDirectory else { return [] }
        
        var options = FileManager.DirectoryEnumerationOptions()
        if relativeURLs                     { options.insert(.producesRelativePathURLs) }
        if !includeHidden                   { options.insert(.skipsHiddenFiles) }
        if !deep && !includePackageContents { options.insert(.skipsPackageDescendants) }
        
        if deep {
            return enumerator(at: url, includingPropertiesForKeys: nil, options: options)?.allObjects as? [URL] ?? []
        } else {
            return try contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: options)
        }
    }
    
    /// Performs a shallow search of the specified directory URL and returns the URLs for any contained items.
    /// - Parameters:
    ///   - url: The URL of the directory whose contents you want to enumerate.
    ///   - includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    /// - Returns: An array of URLs for the contents of the specified directory.
    public func quickScan(url: URL, includeHidden: Bool = false) throws  -> [URL] {
        try contentsOfDirectory(at: url, deepEnumeration: false, relativeURLs: false, includeHidden: includeHidden, includePackageContents: false)
    }
    /// Performs a deep search of the specified directory URL and returns the URLs for any contained items.
    /// - Parameters:
    ///   - url: The URL of the directory whose contents you want to enumerate.
    ///   - relativeURLs: Set to `false` to return full path URLs. Default is set to `true`, returning relative path URLs.
    ///   - includeHidden: Set to `true` to include hidden files in the result. Default is set to `false`, skipping hidden files.
    ///   - includePackageContents: Set to `true` to include package contents in the result. Default is set to `false`, skipping package descendants, treating packages like files.
    /// - Returns: An array of URLs for the contents of the specified directory.
    public func recursiveScan(url: URL, relativeURLs: Bool = true, includeHidden: Bool = false, includePackageContents: Bool = false) throws  -> [URL] {
        try contentsOfDirectory(at: url, deepEnumeration: true, relativeURLs: relativeURLs, includeHidden: includeHidden, includePackageContents: includePackageContents)
    }
    
    // MARK: - Creating Directories
    /// Creates a directory at the specified URL, if it doesn’t already exist, and returns the URL.
    ///
    /// - parameter url: A file URL that specifies the directory to create.
    ///
    /// - returns: The URL for the desired directory.
    @discardableResult public func createDirectory(at url: URL) throws -> URL {
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        
        return url
    }
    
    /// Creates a directory at the specified path, if it doesn’t already exist, and returns its full path.
    ///
    /// - parameter path: The path for the directory to be created.
    ///
    /// - returns: The full path for the desired directory.
    @discardableResult public func createDirectory(at path: FilePath) throws -> String {
        try createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        
        return path.fullUserPath
    }
    
    /// Creates a directory with the specified name in the application support directory.
    /// - Parameter name: The name of the directory to create in the applicationi support directory.
    /// - Returns: A directory with the specified name in the application support directory.
    @discardableResult public func createSupportDirectory(named name: String) throws -> URL {
        try createDirectory(at: .appSupportDocs + name)
    }
    
    // MARK: - Deleting Files and Folders
    /// Permanently removes, i.e. deletes, the file or directory at the specified URL from the system.
    func removeFile(at url: URL) throws {
        guard fileExists(at: url) else { return }
        try removeItem(at: url)
    }
    /// Moves the file or directory at the specified URL to the trash.
    func trashFile(at url: URL) throws {
        guard fileExists(at: url) else { return }
        try trashItem(at: url, resultingItemURL: nil)
    }
    
    // MARK: - Moving and Copying Files and Folders
    private func createDestination(with directory: URL, srcURL: URL, preferredName: String = "") -> URL {
        let fileName = preferredName.isEmpty ? srcURL.lastPathComponent : "\(preferredName).\(srcURL.pathExtension)"
        return directory.appendingPathComponent(fileName)
    }
    
    /// Moves the file or directory at the specified URL to a new location synchronously.
    /// - Parameters:
    ///   - srcURL: The file URL that identifies the file or directory you want to move.
    ///   - directory: The URL of the directory to move the file or directory to.
    ///   - preferredName: The preferred name of the file or directory being moved. Defaults to the name the item has at the source URL.
    ///   - handleDestination: A block to perform on the new location URL after the file has been moved.
    func moveFile(at srcURL: URL, to directory: URL, preferredName: String = "", then handleDestination: ((URL) -> Void) = { _ in }) throws {
        guard fileExists(at: srcURL) else { return }
        let destination = createDestination(with: directory, srcURL: srcURL, preferredName: preferredName)
        
        try moveItem(at: srcURL, to: destination)
        handleDestination(destination)
    }
    
    /// Copies the file or directory at the specified URL to a new location synchronously.
    /// - Parameters:
    ///   - srcURL: The file URL that identifies the file or directory you want to copy.
    ///   - directory: The URL of the directory to copy the file or directory to.
    ///   - preferredName: The preferred name of the file or directory being copied. Defaults to the name the item has at the source URL.
    ///   - handleDestination: A block to perform on the new location URL after the file has been copied.
    func copyFile(at srcURL: URL, to directory: URL, preferredName: String = "", then handleDestination: ((URL) -> Void) = { _ in }) throws {
        guard fileExists(at: srcURL) else { return }
        let destination = createDestination(with: directory, srcURL: srcURL, preferredName: preferredName)
        
        try copyItem(at: srcURL, to: destination)
        handleDestination(destination)
    }
}
