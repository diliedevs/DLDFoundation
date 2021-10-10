//
//  NumericHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation
import CoreGraphics

public extension BinaryInteger {
    /// Returns the integer as the equivalent value in the `Double` type.
    var double: Double {
        return Double(self)
    }
    /// Returns the integer as the equivalent value in the `CGFloat` type.
    var cgfloat: CGFloat {
        return CGFloat(self)
    }
    /// Returns the integer as the equivalent value in the `Int` type.
    var int: Int {
        return numericCast(self)
    }
    /// Returns the integer as the equivalent value in the `Int16` type.
    var int16: Int16 {
        return numericCast(self)
    }
    /// Returns the `Boolean` value of the integer.
    var bool: Bool {
        return self == 1
    }
    /// Returns the string representation of the integer.
    var string: String {
        return String(self)
    }
    /// Returns `true` if the integer is zero.
    var isZero: Bool {
        return self == .zero
    }
    /// Returns `true` if the integer is **not** zero.
    var isNotZero: Bool {
        return isZero == false
    }
    /// Returns `true` if the integer is less than zero.
    var isNegative: Bool {
        return self < .zero
    }
    /// Returns `true`, if the integer is an even number.
    var isEven: Bool {
        return isMultiple(of: 2)
    }
    /// Returns `true`, if the integer is an odd number.
    var isOdd: Bool {
        return isEven == false
    }
    
    /// Returns the integer clamped to the given lower and upper bounds.
    /// - Parameters:
    ///   - start: The lowest value the integer can have.
    ///   - end: The highest value the integer can have.
    func clamped(from start: Self, to end: Self) -> Self {
        self < start ? start : self > end ? end : self
    }
}

public extension BinaryFloatingPoint {
    /// Returns the binary floating point as the equivalent value in the `Int` type.
    var int: Int {
        return Int(self)
    }
    /// Returns the binary floating point as the equivalent value in the `Int16` type.
    var int16: Int16 {
        return Int16(self)
    }
    /// Returns the binary floating point as the equivalent value in the `Double` type.
    var double: Double {
        return Double(self)
    }
    /// Returns the binary floating point as the equivalent value in the `CGFloat` type.
    var cgfloat: CGFloat {
        return CGFloat(self)
    }
    /// Returns the string representation of the binary floating point.
    var string: String {
        return "\(self)"
    }
    /// Returns `true` if the binary floating point is **not** zero.
    var isNotZero: Bool {
        return isZero == false
    }
    /// Returns `true` if the binary floating point is less than zero.
    var isNegative: Bool {
        return self < .zero
    }
    
    /// Returns the binary floating point value rounded to the specified number of decimal digits.
    /// - Parameter fractionDigits: The number of decimal digits to round to.
    func roundedToDecimal(_ fractionDigits: Int) -> Self {
        let multiplier = pow(10, Double(fractionDigits))
        let doubleResult = Darwin.round(self.double * multiplier) / multiplier
        return Self(doubleResult)
    }
    
    /// Returns the binary floating point clamped to the given lower and upper bounds.
    /// - Parameters:
    ///   - start: The lowest value the binary floating point can have.
    ///   - end: The highest value the binary floating point can have.
    func clamped(from start: Self, to end: Self) -> Self {
        self < start ? start : self > end ? end : self
    }
}

public extension SignedNumeric {
    /// Returns the additive inverse of the numeric value.
    var negated: Self {
        var nr = self
        nr.negate()
        return nr
    }
}

public extension SignedNumeric where Self: Comparable {
    /// Returns the absolute value of the signed numeric value.
    var absolute: Self {
        return abs(self)
    }
}

public extension Bool {
    /// Returns the value of the boolean as an `Int`.
    var int: Int {
        return self == true ? 1 : 0
    }
    /// Returns the opposite boolean value.
    var inverted: Bool {
        return !self
    }
}
