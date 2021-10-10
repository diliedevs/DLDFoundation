//
//  PercentageFormatter.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `PercentageFormatter`.
public typealias Perfo = PercentageFormatter

/**
 A subclass of `NumberFormatter` that formats `Double` values into a percentage representation.
 */
public class PercentageFormatter: NumberFormatter {
    
    // MARK: - Creating a Percentage Formatter
    /// Creates and returns an `NumberFormatter` object configured to display percentage amounts.
    ///
    /// - parameter fractions:   A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    ///
    /// - returns: A `NumberFormatter` object configured to display percentage amounts.
    public required init(fractions: MinMax) {
        super.init()
        numberStyle = .percent
        minimumFractionDigits = fractions.mininum
        maximumFractionDigits = fractions.maximum
        percentSymbol = " %"
    }
    
    /// Required `init` method to conform to the `NSCoder` class.
    ///
    /// - parameter coder:  The `NSCoder` object.
    ///
    /// - returns: An instance of the `CurrencyFormatter` that conforms tot `NSCoder` class.
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Getting a String Representation
    /// Returns a string containing the formatted percentage representation for the specified double value.
    ///
    /// - parameter double:      The `Double` value that is parsed to create the returned string object.
    /// - parameter fractions:   A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    /// - parameter defaultString:  The default string to return (an empty string by default).
    ///
    /// - returns: A string containing the formatted percentage representation of the `double` using the percentage formatter's settings.
    public class func string(for double: Double, fractions: MinMax, default defaultString: String = "") -> String {
        return PercentageFormatter(fractions: fractions).string(for: double, default: defaultString)
    }
}

public extension Double {
    /// Returns a string containing the formatted percentage value for the receiving `Double` value.
    ///
    /// - Parameters:
    ///   - fractions: A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    ///   - defaultString: The default string to return (an empty string by default).
    /// - Returns: A string containing the formatted percentage value for the receiving `Double` value.
    func perfoed(with fractions: MinMax, default defaultString: String = "") -> String {
        return Perfo.string(for: self, fractions: fractions, default: defaultString)
    }
}
