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
    /// - Parameter defaultValue: A default string value to return in case the key is not present in the dictionary. This defaults to an empty string.
    /// - Returns: The value associated with `key` as a `String`, or the default string value provided if the `key` is not in the dictionary.
    func string(for key: String, defaultValue: String = "") -> String {
        return self[key] as? String ?? defaultValue
    }
    /// Returns the value associated with the given key as an `Int`.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Parameter defaultValue: A default integer value to return in case the key is not present in the dictionary. This defaults to `0`.
    /// - Returns: The value associated with `key` as an `Int`, or the default integer value provided if the `key` is not in the dictionary.
    func int(for  key: String, defaultValue: Int = 0) -> Int {
        return self[key] as? Int ?? defaultValue
    }
    /// Returns the value associated with the given key as a `Double`.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Parameter defaultValue: A default double value to return in case the key is not present in the dictionary. This defaults to `0.0`.
    /// - Returns: The value associated with `key` as a `Double`, or the default double value if the `key` is not in the dictionary.
    func double(for  key: String, defaultvalue: Double = 0.0) -> Double {
        return self[key] as? Double ?? defaultvalue
    }
}

public extension Dictionary where Value: OptionalType {
    func removingNilValues() -> [Key: Value.Wrapped] {
        self.compactMapValues { $0.optional }
    }
}
