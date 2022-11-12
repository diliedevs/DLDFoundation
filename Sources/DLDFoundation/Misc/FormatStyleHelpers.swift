//
//  FormatStyleHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 29/01/2022.
//  Copyright © 2022 DiLieDevs. All rights reserved.
//

import Foundation

@available(macOS 12.0, iOS 15.0, *)
public extension Date.ISO8601FormatStyle {
    /// Returns only the year, month, and day in ISO8601 format style, i.e. `2022-01-29`.
    func date() -> Self {
        self.year().month().day()
    }
}

@available(macOS 12.0, iOS 15.0, *)
public extension FormatStyle where Self == Date.FormatStyle {
    /// Returns the numerical date only with the day and month padded with a leading `0`, i.e. `01-01-2022`
    static var paddedDate: Self {
        dateTime.day(.twoDigits).month(.twoDigits).year()
    }
}

@available(macOS 12.0, iOS 15.0, *)
public extension FloatingPointFormatStyle where Value: BinaryFloatingPoint {
    /// Returns the binary floating point value with the given length of fractional digits.
    /// - Parameter length: The number of digits after the decimal separator.
    func fractions(_ length: Int) -> Self {
        self.precision(.fractionLength(length))
    }
}

@available(macOS 12.0, iOS 15.0, *)
public extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static func euros() -> Self {
        currency(code: "EUR")
    }
    
    static func usDollars() -> Self {
        currency(code: "USD")
    }
    
    static func localEuros() -> Self {
        currency(code: Locale.current.currencyCode ?? "EUR")
    }
    
    static func localUSDollars() -> Self {
        currency(code: Locale.current.currencyCode ?? "USD")
    }
}
