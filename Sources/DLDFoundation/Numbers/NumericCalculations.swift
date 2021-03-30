//
//  NumericCalculations.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension BinaryInteger {
    /// Adds a binary floating point value to a binary integer value and produces their sum in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: The binary floating point type value to add to `lhs`. The result of the addition will be in this type.
    static func + <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) + rhs
    }
    /// Adds a binary integer value to a binary floating point value and produces their sum in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the addition will be in this type.
    ///   - rhs: The binary integer type value to add to `lhs`.
    static func + <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs + T(rhs)
    }
    /// Substracts a binary floating point value from a binary integer value and produces their difference in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: The binary floating point type value to substract from `lhs`. The result of the subtraction will be in this type.
    static func - <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) - rhs
    }
    /// Substracts a binary integer value from a binary floating point value and produces their difference in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the subtraction will be in this type.
    ///   - rhs: The binary integer type value to substract from `lhs`.
    static func - <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs - T(rhs)
    }
    /// Multiplies a binary floating point value with a binary integer value and produces their product in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: The binary floating point type value to multiply `lhs` with. The result of the multiplication will be in this type.
    static func * <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) * rhs
    }
    /// Multiplies a binary integer value with a binary floating point value and produces their product in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the multiplication will be in this type.
    ///   - rhs: The binary integer type value to multiply `lhs` with.
    static func * <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs * T(rhs)
    }
    /// Divides a binary integer value by a binary floating point value and produces their quotient in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: The binary floating point type value to divide `lhs` by. The result of the division will be in this type.
    static func / <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) / rhs
    }
    /// Divides a binary floating point value by a binary integer value and produces their quotient in the binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the division will be in this type.
    ///   - rhs: The binary integer type value to divide `lhs` by.
    static func / <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs / T(rhs)
    }
    
    /// Adds a binary integer value to another binary integer value and produces their sum in the second binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: Another binary integer type value to add to `lhs`. The result of the addition will be in this type.
    static func + <T>(lhs: Self, rhs: T) -> T where T: BinaryInteger {
        return T(lhs) + rhs
    }
    /// Adds a binary integer value to another binary integer value and produces their sum in the first binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value. The result of the addition will be in this type.
    ///   - rhs: Another binary integer type value to add to `lhs`.
    static func + <T>(lhs: T, rhs: Self) -> T where T: BinaryInteger {
        return lhs + T(rhs)
    }
    /// Substracts a binary integer value from another binary integer value and produces their difference in the second binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: Another binary integer type value to substract from `lhs`. The result of the substraction will be in this type.
    static func - <T>(lhs: Self, rhs: T) -> T where T: BinaryInteger {
        return T(lhs) - rhs
    }
    /// Substracts a binary integer value from another binary integer value and produces their difference in the first binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value. The result of the substraction will be in this type.
    ///   - rhs: Another binary integer type value to substract from `lhs`.
    static func - <T>(lhs: T, rhs: Self) -> T where T: BinaryInteger {
        return lhs - T(rhs)
    }
    /// Multiplies a binary integer value with another binary integer value and produces their product in the second binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: Another binary integer type value to multiply `lhs` with. The result of the multiplication will be in this type.
    static func * <T>(lhs: Self, rhs: T) -> T where T: BinaryInteger {
        return T(lhs) * rhs
    }
    /// Multiplies a binary integer value with another binary integer value and produces their product in the first binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value. The result of the multiplication will be in this type.
    ///   - rhs: Another binary integer type value to multiply `lhs` with.
    static func * <T>(lhs: T, rhs: Self) -> T where T: BinaryInteger {
        return lhs * T(rhs)
    }
    /// Divides a binary integer value by another binary integer value and produces their quotient in the second binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value.
    ///   - rhs: Another binary integer type value to divide `lhs` by. The result of the division will be in this type.
    static func / <T>(lhs: Self, rhs: T) -> T where T: BinaryInteger {
        return T(lhs) / rhs
    }
    /// Divides a binary integer value by another binary integer value and produces their quotient in the first binary integer type.
    /// - Parameters:
    ///   - lhs: A binary integer type value. The result of the division will be in this type.
    ///   - rhs: Another binary integer type value to divide `lhs` by.
    static func / <T>(lhs: T, rhs: Self) -> T where T: BinaryInteger {
        return lhs / T(rhs)
    }
}

public extension BinaryFloatingPoint {
    /// Adds a binary floating point value to another binary floating point value and produces their sum in the second binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value.
    ///   - rhs: Another binary floating point type value to add to `lhs`. The result of the addition will be in this type.
    static func + <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) + rhs
    }
    /// Adds a binary floating point value to another binary floating point value and produces their sum in the first binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the addition will be in this type.
    ///   - rhs: Another binary floating point type value to add to `lhs`.
    static func + <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs + T(rhs)
    }
    /// Substracts a binary floating point value from another binary floating point value and produces their difference in the second binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value.
    ///   - rhs: Another binary floating point type value to substract from `lhs`. The result of the substraction will be in this type.
    static func - <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) - rhs
    }
    /// Substracts a binary floating point value from another binary floating point value and produces their difference in the first binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the substraction will be in this type.
    ///   - rhs: Another binary floating point type value to substract from `lhs`.
    static func - <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs - T(rhs)
    }
    /// Multiplies a binary floating point value with another binary floating point value and produces their product in the second binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value.
    ///   - rhs: Another binary floating point type value to multiply `lhs` with. The result of the multiplication will be in this type.
    static func * <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) * rhs
    }
    /// Multiplies a binary floating point value with another binary floating point value and produces their product in the first binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the multiplication will be in this type.
    ///   - rhs: Another binary floating point type value to multiply `lhs` with.
    static func * <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs * T(rhs)
    }
    /// Divides a binary floating point value by another binary floating point value and produces their quotient in the second binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value.
    ///   - rhs: Another binary floating point type value to divide `lhs` by. The result of the division will be in this type.
    static func / <T>(lhs: Self, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs) / rhs
    }
    /// Divides a binary floating point value by another binary floating point value and produces their quotient in the first binary floating point type.
    /// - Parameters:
    ///   - lhs: A binary floating point type value. The result of the division will be in this type.
    ///   - rhs: Another binary floating point type value to divide `lhs` by.
    static func / <T>(lhs: T, rhs: Self) -> T where T: BinaryFloatingPoint {
        return lhs / T(rhs)
    }
}
