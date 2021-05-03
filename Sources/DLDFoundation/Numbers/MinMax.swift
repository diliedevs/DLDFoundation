//
//  MinMax.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A structure that contains a minimum and maximum integer number and can provide ranges for those numbers.
public struct MinMax {
    /// The minimum integer number.
    public let mininum: Int
    /// The maximum integer number.
    public let maximum: Int
    
    /// Creates a `MinMax` struct with the given integer numbers.
    /// - Parameters:
    ///   - min: The minimum integer number.
    ///   - max: The maximum integer number.
    public init(_ min: Int, _ max: Int) {
        self.mininum = min
        self.maximum = max
    }
    
    /// Returns a closed range from the minimum number up to, and including, the maximum number.
    public var closedRange: ClosedRange<Int> {
        mininum...maximum
    }
    /// Returns a range from the minimum number up to, but not including, the maximum number.
    public var range: Range<Int> {
        mininum..<maximum
    }
    
    /// Returns `true` if the specified number is between the minimum and maximum.
    /// - Parameters:
    ///   - element: The number to find between the minimum and maximum.
    ///   - includingMax: Set to `false` to exclude the maximum number from the range to search through.
    public func contains(_ element: Int, includingMax: Bool = true) -> Bool {
        return includingMax ? closedRange.contains(element) : range.contains(element)
    }
}

public extension MinMax {
    static let none   = MinMax(0, 0)
    static let ohTwo  = MinMax(0, 2)
    static let twoTwo = MinMax(2, 2)
}
