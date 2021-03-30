//
//  DictionaryHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    
    // MARK: - Getting values as a specific type
    /// Returns the value associated with the given key as a `String`.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Returns: The value associated with `key` as a `String`, or an empty string if the `key` is not in the dictionary.
    func string(for key: String) -> String {
        return self[key] as? String ?? ""
    }
    /// Returns the value associated with the given key as an `Int`.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Returns: The value associated with `key` as an `Int`, or `0` if the `key` is not in the dictionary.
    func int(for  key: String) -> Int {
        return self[key] as? Int ?? 0
    }
    /// Returns the value associated with the given key as a `Double`.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Returns: The value associated with `key` as a `Double`, or `0.0` if the `key` is not in the dictionary.
    func double(for  key: String) -> Double {
        return self[key] as? Double ?? 0.0
    }
}
