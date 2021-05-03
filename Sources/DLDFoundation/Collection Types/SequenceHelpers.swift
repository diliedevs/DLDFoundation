//
//  SequenceHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Sequence {
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
    
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>, ascending: Bool) -> [Element] {
        self.sorted(by: keyPath) { first, second -> Bool in
            return ascending ? first < second : first > second
        }
    }
    
    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }
    
    func sorted(by sortDescriptors: [NSSortDescriptor]) -> [Element] {
        self.sorted {
            for descriptor in sortDescriptors {
                switch descriptor.compare($0, to: $1) {
                case .orderedAscending : return true
                case .orderedDescending: return false
                case .orderedSame      : continue
                }
            }
            
            return false
        }
    }
    
    func filter(unless allCondition: Bool, isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        try self.filter {
            guard !allCondition else { return true }
            
            return try isIncluded($0)
        }
    }
    
    func grouped<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Value: [Element]] {
        Dictionary(grouping: self) { $0[keyPath: keyPath] }
    }
}

public extension Sequence where Element: StringProtocol {
    /// A string representing all the elements of the sequence joined together by a comma and a space (`, `).
    var commaSeparated: String {
        joined(separator: ", ")
    }
}

public extension Sequence where Element: Numeric {
    func sum() -> Element {
        reduce(0, +)
    }
}

public extension Collection {
    /// A Boolean value indicating whether the collection is not empty.
    var isNotEmpty: Bool {
        return isEmpty == false
    }
}
