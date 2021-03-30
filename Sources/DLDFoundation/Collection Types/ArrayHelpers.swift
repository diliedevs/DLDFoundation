//
//  ArrayHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Array {
    
    // MARK: - Converting to NSArray
    /// An NSArray object representing the array.
    var nsArray: NSArray {
        return NSArray(array: self)
    }
    
    // MARK: - Adding Elements
    /// Inserts a new element at the beginning of the array.
    ///
    /// - Parameter newElement: The element to insert at the beginning of the array.
    mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    /// Replaces the element at the specified index with the new given element.
    ///
    /// - parameter index:      The index of the element to replace.
    /// - parameter newElement: The new element to replace the old one at the specified index.
    mutating func replace(at index: Int, with newElement: Element) {
        replaceSubrange(index...index, with: [newElement])
    }
    
    // MARK: - Iterating Over an Array's Elements
    /// Passes through each element with their index in the array and performs the specified code block on them.
    ///
    /// - parameter body: A closure that takes an element of the sequence and its index as a parameter.
    func forEachIndex(_ body: (Int, Element) -> Void) {
        for (index, item) in enumerated() {
            body(index, item)
        }
    }
}

public extension Array where Element: Hashable {
    // MARK: - Transforming an Array
    /// Returns a new array without duplicate values of any element, the elements conform to the `Hashable` protocol.
    ///
    /// - Returns: A new array without duplicate values of any element.
    func uniqued() -> [Element] {
        return Array(Set(self))
    }
}
