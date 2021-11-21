//
//  Comparable.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 21/11/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Comparable {
    /// Returns the comparable element clamped to the given lower and upper bounds.
    /// - Parameters:
    ///   - start: The lowest value the comparable element can have.
    ///   - end: The highest value the comparable element can have.
    func clamp(low: Self, high: Self) -> Self {
        if self > high {
            return high
        } else if self < low {
            return low
        }
        
        return self
    }
}
