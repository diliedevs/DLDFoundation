//
//  Logger.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

#if os(OSX)
import AppKit
#elseif os(iOS)
import UIKit
#endif

/**
 The `Logger` structure is to write prettier, friendlier, textual representations of items into the console with emoji prefixes for extra clarity.
 
 Here is breakdown of what a `Logger` log looks like:
 
 - The log starts on a new line with the time of logging inside of square brackets followed by a colon, like `[18:33:24]:`
 - If the calling function is not the postfix operator `/`, the filename, line number and function name are appended to the time, like `[18:33:24, ›MyFile ›26 ›myFunction]:`
 - The log continues on a new line with the emoji representing the type of object being logged follow by the textual representation of the object, like `🌐 http://www.diliedevs.com`
 - If there is a custom `prefix`, the emoji is first followed by the custom prefix, a colon and then the the textual representation of the object, like `🌐 myURL: http://www.diliedevs.com`
 - If the object is an NSError, the error is represented by its code, if it has one, and its localized description, like `‼️ 404: File not found`
 */
public struct Logger {
    
    enum LogType : String {
        case url = "🌐"
        case date = "📆"
        case error = "‼️"
        case string = "🔡"
        case number = "🔢"
        case object = "🔶"
        case line = "✳️"
        
        static func type(forObject object: Any) -> LogType {
            switch object {
            case is URL      : return .url
            case is Date     : return .date
            case is NSError,
                 is Error    : return .error
            case is String,
                 is NSString : return .string
            case is Int,
                 is Double,
                 is NSNumber,
                 is CGFloat  : return .number
            case is NSObject : return .object
            default          : return .line
            }
        }
    }
    
    // MARK: - Logging Items to the Console
    /// Writes a prettier, friendlier, textual representation of the specified item into the console.
    ///
    /// - parameter item:        The item to write the textual representation of.
    /// - parameter prefix:     The optional message to write between the emoji and the `item`. Default is nothing.
    /// - parameter file:        The file the item being logged is written in.
    /// - parameter line:        The line in the file the item being logged is written on.
    /// - parameter function:    The name of the function the item being logged is in.
    public static func slog(_ item: Any, prefix: String = "", file: String = #file, line: UInt = #line, function: String = #function) {
        let type = LogType.type(forObject: item).rawValue
        let time = Date.now.string(withFormat: .HHmmss)
        let filename = file.lastPathComponent.withoutExtension
        
        var msg = "\n[\(time)"
        
        if function != "§" {
            msg += ", ›\(filename) ›\(line) ›\(function)"
        }
        msg += "]:\n\(type) "
        
        if prefix.isNotEmpty { msg += "\(prefix): " }
        
        if item is NSError {
            let error = item as! NSError
            msg += "\(error.code): " + error.localizedDescription
        }
        else {
            msg += "\(item)"
        }
        
        Swift.print(msg)
    }
}

// MARK: - Logging Items to the Console
/// Writes a prettier, friendlier, textual representation of the specified item into the console.
///
/// - parameter item:        The item to write the textual representation of.
/// - parameter prefix:     The optional message to write between the emoji and the `item`. Default is nothing.
/// - parameter file:        The file the item being logged is written in.
/// - parameter line:        The line in the file the item being logged is written on.
/// - parameter function:    The name of the function the item being logged is in.
public func slog(_ item: Any, prefix: String = "", file: String = #file, line: UInt = #line, function: String = #function) {
    //    #if DEBUG
    Logger.slog(item, prefix: prefix, file: file, line: line, function: function)
    //    #endif
}

postfix operator §

/// Writes a prettier, friendlier, textual representation of the preceding object into the console and returns the item.
///
/// - Parameter object: The object preceding the `§` postfix operator.
/// - parameter file:        The file the item being logged is written in.
/// - parameter line:        The line in the file the item being logged is written on.
/// - parameter function:    The name of the function the item being logged is in.
/// - Returns: The object preceding the `§` postfix operator.
public postfix func § <T: Any>(object: T) -> T {
    Logger.slog(object, prefix: "", file: #file, line: #line, function: #function)
    
    return object
}
