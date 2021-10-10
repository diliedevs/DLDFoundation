//
//  CurrencyFormatter.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `CurrencyFormatter`.
public typealias Curfo = CurrencyFormatter

/**
 A subclass of `NumberFormatter` that formats `Double` values into an accounting style currency representation.
 
 - seealso: `MaxDigits` for setting the maximum number of integer digits.
 */
public class CurrencyFormatter: NumberFormatter {
    
    // MARK: - Creating a Currency Formatter
    /// /// Creates and returns a `NumberFormatter` object configured to display accounting style currency amounts.
    /// - Parameters:
    ///   - maxDigits: The maximum number of integer digits the value to format can have. This is used to set the format width and maximum integer digits alowed.
    ///   - negative: Where to display a negative if negative values are allowed.
    public required init(maxDigits: MaxDigits, negative: NegativePlacement = .none) {
        super.init()
        setDigits(maxInteger: maxDigits.rawValue, fractions: MinMax(2, 2), width: maxDigits.formatWidth, negative: negative)
        let spaces = " ".repeated(times: formatWidth - negative.width - 1)
        zeroSymbol = "\(currencySymbol!)\(spaces)–\(positivePrefix!)"
        negativePrefix = currencySymbol! + negativePrefix
        positivePrefix += currencySymbol!
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
    /// Returns a string containing the formatted currency representation for the specified double value.
    ///
    /// - parameter double:         The `Double` value that is parsed to create the returned string.
    /// - parameter maxDigits:      The maximum number of integer digits the `double` to format can have. This is used to set the format width and maximum integer digits alowed.
    /// - parameter negative:       Where to display a negative if negative values are allowed.
    /// - parameter defaultString:  The default string to return (an empty string by default).
    ///
    /// - returns: A string containing the formatted currency representation of `double` using the currency formatter's settings.
    public class func string(for double: Double, maxDigits: MaxDigits, negative: NegativePlacement = .none, default defaultString: String = "") -> String {
        let cf = CurrencyFormatter(maxDigits: maxDigits, negative: negative)
        return cf.string(for: double, negative: negative, default: defaultString)
    }
}

public extension Double {
    /// Returns a string containing the formatted currency representation for the receiving `Double` value.
    ///
    /// - Parameters:
    ///   - maxDigits: The maximum number of integer digits the receiver can have. This is used to set the format width and maximum integer digits alowed.
    ///   - negative: Where to display a negative if negative values are allowed.
    ///   - defaultString: The default string to return (an empty string by default).
    ///
    /// - returns: A string containing the formatted currency representation of `double` using the currency formatter's settings.
    func curfoed(with maxDigits: MaxDigits, negative: NumberFormatter.NegativePlacement = .none, default defaultString: String = "") -> String {
        return Curfo.string(for: self, maxDigits: maxDigits, negative: negative, default: defaultString)
    }
}
