//
//  ErrorHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Error {
    /// A type alias for a closure passing an `Error` object to be handled accordingly.
    typealias Handler = (Error) -> Void
    
    // MARK: - Handling an Error
    /// Prints the localized description of the error in the console then handles it according to the specified block of code.
    /// - Parameters:
    ///   - message: A custom message to prefic the log in the console.
    ///   - handle: The block of code to handle the error after printing it in the console.
    func log(withMessage message: String, then handle: Handler? = nil) {
        slog(self.localizedDescription, prefix: message)
        handle?(self)
    }
    
    /// Prints the localized description of the error with a localized, basic "Unhandled Error" log message in the console then handles it according to the specified block of code.
    /// - Parameter handle: The block of code to handle the error after printing it in the console.
    func log(then handle: Handler? = nil) {
        self.log(withMessage: "Unhandled error", then: handle)
    }
}

public extension NSError {
    // MARK: - Handling an Error
    /// Prints the localized description of the error in the console then handles it according to the specified block of code.
    /// - Parameters:
    ///   - message: A custom message to prefic the log in the console.
    ///   - handle: The block of code to handle the error after printing it in the console.
    func log(withMessage message: String, then handle: Handler? = nil) {
        slog(self.localizedDescription, prefix: message)
        handle?(self)
    }
    
    /// Prints the localized description of the error with a localized, basic "Unhandled Error" log message in the console then handles it according to the specified block of code.
    /// - Parameter handle: The block of code to handle the error after printing it in the console.
    func log(then handle: Handler? = nil) {
        self.log(withMessage: "Unhandled error", then: handle)
    }
}
