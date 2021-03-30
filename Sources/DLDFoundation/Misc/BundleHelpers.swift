//
//  BundleHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Bundle {
    
    // MARK: - Bundle Information
    /// The name of the application.
    var name: String {
        return string(forKey: .name)
    }
    /// The current version of the application.
    var version: String {
        return string(forKey: .releaseVersion)
    }
    /// The build number as a string of the application.
    var build: String {
        return string(forKey: .buildVersion)
    }
    /// The full version, including the build number, of the application. This will result in something like `1.7 (6)`.
    var fullVersion: String {
        return "\(version) (\(build))"
    }
    /// The name of the application with all spaces replaced by an underscore `_`.
    var underscoredName: String {
        return name.replacing(target: " ", with: "_")
    }
    /// The name of the application with all spaces replaced by a dash `-`.
    var dashedName: String {
        return name.replacing(target: " ", with: "-")
    }
    
    // MARK: - Getting Bundle Information
    /// Returns the string value associated with the specified key in the bundle's information property list.
    ///
    /// - Parameter key: The key in the bundle's property list.
    /// - Returns: The string value associated with `key` in the receiver's property list (`Info.plist`).
    func string(forKey key: String) -> String {
        return object(forInfoDictionaryKey: key) as? String ?? ""
    }
    
    /// Returns the string value associated with the specified key in the bundle's information property list.
    ///
    /// - Parameter key: The `InfoPlistKey` key in the bundle's property list.
    /// - Returns: The string value associated with `key` in the receiver's property list (`Info.plist`).
    func string(forKey key: InfoPlistKey) -> String {
        return string(forKey: key.rawValue)
    }
    
    // MARK: - Getting Bundle Files
    func urlForFile(_ filename: String, inDirectory directory: String? = nil) -> URL? {
        url(forResource: filename, withExtension: nil, subdirectory: directory)
    }
    
    func contentsOfFile(_ filename: String, inDirectory directory: String? = nil) -> String? {
        guard let url = urlForFile(filename, inDirectory: directory) else { return nil }
        
        return try? String(contentsOf: url)
    }
}

/// The following constants specify the keys in a bundle's `Info.plist`.
public enum InfoPlistKey: String, CaseIterable {
    /// The value for this key is the short name for the bundle, usually the name of the application.
    case name = "CFBundleName"
    /// The value for this key is the localized version of the application name. The localized value is typically located in an `InfoPlist.strings` file in each of the language-specific resource directories.
    case displayName = "CFBundleDisplayName"
    /// The value for this key is a string that identifies the application to the system, and should be in reverse-DNS format, i.e. `com.diliedevs.Codex`.
    case identifier = "CFBundleIdentifier"
    /// The value for this key is a string that specifies the build version number of the bundle.
    case buildVersion = "CFBundleVersion"
    /// The value for this key is a string specifying the release version of the application.
    case releaseVersion = "CFBundleShortVersionString"
    /// The value for this key is a string of the form `n.n.n` representing the minimum version of the operating system required for the application to run.
    case minimumSystemVersion = "LSMinimumSystemVersion"
    /// The value for this key is a human readable string representing the copyright notice for the application.
    case copyright = "NSHumanReadableCopyright"
}
