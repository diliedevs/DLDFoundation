//
//  FileNode.swift
//  
//
//  Created by Dionne Lie Sam Foek on 13/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import Foundation

@available(macOS 13.0, iOS 16.0, *)
public protocol FileNode {
    var name      : String      { get set }
    var wrapper   : FileWrapper { get }
}

@available(macOS 13.0, iOS 16.0, *)
public extension FileNode {
    func write(to directory: URL, options: FileWrapper.WritingOptions = [], originalContentsURL: URL? = nil) throws {
        let url = directory.appending(path: name)
        try wrapper.write(to: url, options: options, originalContentsURL: originalContentsURL)
    }
}

@available(macOS 13.0, iOS 16.0, *)
private extension FileNode {
    func create(from wrapper: FileWrapper) -> FileWrapper {
        wrapper.preferredFilename = name
        wrapper.fileAttributes[FileAttributeKey.creationDate.rawValue] = Date.now
        wrapper.fileAttributes[FileAttributeKey.modificationDate.rawValue] = Date.now
        
        return wrapper
    }
}

@available(macOS 13.0, iOS 16.0, *)
public struct File: FileNode {
    public var name: String
    public let content: String
    
    public var wrapper: FileWrapper {
        let wrap = FileWrapper(regularFileWithContents: Data(content.utf8))
        return create(from: wrap)
    }
    
    public init(name: String, content: String) {
        self.name = name
        self.content = content
    }
}

@available(macOS 13.0, iOS 16.0, *)
public struct Folder: FileNode {
    public var name: String
    public let children: [FileNode]
    
    public var wrapper: FileWrapper {
        let kids = children.reduce(into: [:]) {
            $0[$1.name] = $1.wrapper
        }
        let wrap = FileWrapper(directoryWithFileWrappers: kids)
        return create(from: wrap)
    }
    
    public init(name: String, children: [FileNode]) {
        self.name = name
        self.children = children
    }
}
