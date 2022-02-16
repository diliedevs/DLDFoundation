//
//  SetHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Set {
    /// Returns an array of all the elements in the set.
    var elements: [Element] {
        return Array(self)
    }
}

public extension Array where Element: Hashable {
    /// Returns an unordered set of unique elements in the array.
    func toSet() -> Set<Element> {
        return Set(self)
    }
}

public extension Optional where Wrapped == NSSet {
    /// Returns an array of all the elements in the optional `NSSet` as the given type or an empty array.
    func asArray<T>(of type: T.Type) -> [T] {
        guard let theSet = self else { return [] }
        
        return theSet.allObjects as? [T] ?? []
    }
}

public extension SetAlgebra {
    /// Toggles the given element of the set, by removing it if it is present in the set, or otherwise inserting it.
    /// - Parameter element: The element of the set to toggle.
    mutating func toggle(_ element: Element) {
        if self.contains(element) { remove(element) }
        else                      { insert(element) }
    }
}
