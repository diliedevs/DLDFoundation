//
//  FilePathHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 29/10/2022.
//  Copyright © 2022 DiLieDevs. All rights reserved.
//

import Foundation
import SystemPackage

public extension FilePath {
    /// Returns the url for the file path.
    var url: URL {
        if #available(macOS 13.0, iOS 16.0.0, *) {
            return URL(filePath: self.string)
        }
        
        return URL(fileURLWithPath: self.string)
    }
    
    /// Returns a Boolean value that indicates whether a file or directory exists at the specified path.
    var exists: Bool {
        return url.exists
    }
    
    /// Returns `true` if the receiving path represents a folder or directory.
    var isFolder: Bool {
        url.isDirectory
    }
    /// Returns `true` if the receiving path represents a file.
    var isFile: Bool {
        isFolder == false
    }
    
    /// Creates a new path with everything up to but not including lastComponent.
    var directory: FilePath {
        self.removingLastComponent()
    }
    
    /// Returns the name of the file at the receiving path without the path extension.
    var name: String? {
        stem
    }
}
