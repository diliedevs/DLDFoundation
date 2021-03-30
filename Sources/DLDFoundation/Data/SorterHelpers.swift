//
//  SorterHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `NSSortDescriptor`.
public typealias Sorter = NSSortDescriptor

public extension NSSortDescriptor {
    
    // MARK: - Creating Sort Descriptors
    /// Returns a sort descriptor initialized with the specified key path and ascending sort order.
    /// - Parameter keyPath: The key path to use when performing a comparison.
    class func ascKeyPath<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> NSSortDescriptor {
        return .init(keyPath: keyPath, ascending: true)
    }
    /// Returns a sort descriptor initialized with the specified key path and descending sort order.
    /// - Parameter keyPath: The key path to use when performing a comparison.
    class func descKeyPath<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> NSSortDescriptor {
        return .init(keyPath: keyPath, ascending: false)
    }
    /// Returns a sort descriptor initialized with the specified key path and ascending sort order.
    /// - Parameter keyPath: The property key to use when performing a comparison.
    class func ascKey(_ key: String) -> NSSortDescriptor {
        return .init(key: key, ascending: true)
    }
    /// Returns a sort descriptor initialized with the specified key path and descending sort order.
    /// - Parameter keyPath: The property key to use when performing a comparison.
    class func descKey(_ key: String) -> NSSortDescriptor {
        return .init(key: key, ascending: false)
    }
}
