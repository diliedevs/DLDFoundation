//
//  NumberFormatterHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `NumberFormatter`.
public typealias Numfo = NumberFormatter

public extension NumberFormatter {
    /// The following constants specify whether the number formatter should display negative values, and if so, where to display the negative symbol.
    enum NegativePlacement {
        /// Display the negative symbol before the value.
        case prefix(String)
        /// Display the negative symbol after the value.
        case suffix(String)
        /// Display a symbol before and after the value.
        case both(String, String)
        /// Do not display negative values.
        case none
        
        var width: Int {
            switch self {
            case .prefix(let pre): return pre.count
            case .suffix(let suf): return suf.count
            case .both(let pre, let suf): return pre.count + suf.count
            case .none: return 1
            }
        }
        
        func value(for double: Double) -> Double {
            switch self {
            case .none: return double.absolute
            case _: return double
            }
        }
    }
    
    // MARK: - Initializers
    /// Creates and returns a `NumberFormatter` object configured with the specified number style.
    /// - Parameter style: The number style used by the receiver.
    convenience init(style: Style) {
        self.init()
        self.numberStyle = style
    }
    
    /// Creates and returns a `NumberFormatter` object configured to display according to the given parameters.
    ///
    /// - Parameters:
    ///   - maxInteger: The maximum number of integer digits allowed as input and output.
    ///   - fractions: A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    ///   - width: The format width (number of characters) used by the formatter.
    ///   - negative: Where to display a negative if negative values are allowed.
    convenience init(maxInteger: Int, fractions: MinMax, width: Int, negative: NegativePlacement = .none) {
        self.init()
        setDigits(maxInteger: maxInteger, fractions: fractions, width: width, negative: negative)
    }
    
    /// Creates and returns a `NumberFormatter` object configured to display according to the given parameters.
    /// - Parameter maxDigits: The maximum number of integer digits the value to format can have. This is used to set the format width and maximum integer digits alowed.
    /// - parameter fractions:   A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    /// - parameter negative: Where to display a negative if negative values are allowed.
    convenience init(maxDigits: MaxDigits, fractions: MinMax, negative: NegativePlacement = .none) {
        self.init(maxInteger: maxDigits.rawValue, fractions: fractions, width: maxDigits.formatWidth, negative: negative)
    }
    
    // MARK: - Converting Between Numbers and Strings
    /// Returns a string containing the formatted value for the specified `double` value.
    ///
    /// - Parameters:
    ///   - double: The `Double` value that is parsed to create the returned string object.
    ///   - negative: Where to display a negative if negative values are allowed.
    ///   - defaultString: The default string to return (an empty string by default).
    /// - Returns: A string containing the formatted value of `double` using the formatter's current settings or the given default string if the value could not be converted to a string.
    func string(for double: Double, negative: NegativePlacement = .none, default defaultString: String = "") -> String {
        return string(from: NSNumber(value: negative.value(for: double))) ?? defaultString
    }
    
    /// Returns a string containing the formatted value for the specified `double` value.
    ///
    /// - Parameters:
    ///   - double: The `Double` value that is parsed to create the returned string object.
    ///   - maxDigits: The maximum number of integer digits the value to format can have. This is used to set the format width and maximum integer digits alowed.
    ///   - fractions: A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    ///   - negative: Where to display a negative if negative values are allowed.
    ///   - defaultString: The default string to return (an empty string by default).
    /// - Returns: A string containing the formatted value of `double` using the specified settings or the given default string if the value could not be converted to a string.
    class func string(for double: Double, maxDigits: MaxDigits = .triple, fractions: MinMax = MinMax(2, 2), negative: NegativePlacement = .none, default defaultString: String = "") -> String {
        let nf = NumberFormatter(maxDigits: maxDigits, fractions: fractions, negative: negative)
        return nf.string(for: double, negative: negative, default: defaultString)
    }
    
    // MARK: - Configuring the Formatter
    /// Sets standard values for the formatter's properties. The formatter has a minimum of 1 integer digit, is set to localize and is padded with a space after the prefix.
    ///
    /// - parameter maxInteger:      The maximum number of integer digits allowed as input and output.
    /// - parameter fractions:   A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    /// - parameter width:       The format width (number of characters) used by the formatter.
    /// - parameter negative: Where to display a negative if negative values are allowed.
    func setDigits(maxInteger: Int, fractions: MinMax, width: Int, negative: NegativePlacement = .none) {
        minimumIntegerDigits  = 1
        maximumIntegerDigits  = maxInteger
        minimumFractionDigits = fractions.mininum
        maximumFractionDigits = fractions.maximum
        paddingPosition       = .afterPrefix
        paddingCharacter      = " "
        formatWidth           = width + negative.width
        
        switch negative {
        case .prefix(let pre): setPrefixes(negative: pre)
        case .suffix(let suf): setSuffixes(negative: suf)
        case .both(let pre, let suf):
            setPrefixes(negative: pre)
            setSuffixes(negative: suf)
        case .none: break
        }
    }
    
    private func setPrefixes(negative: String) {
        negativePrefix = negative
        positivePrefix = ""
    }
    
    private func setSuffixes(negative: String) {
        negativeSuffix = negative
        positiveSuffix = " ".repeated(times: negative.count)
    }
}

public extension Double {
    /// Returns a string containing the formatted value for the receiving `Double` value.
    ///
    /// - Parameters:
    ///   - maxDigits: The maximum number of integer digits the value to format can have. This is used to set the format width and maximum integer digits alowed.
    ///   - fractions: A `MinMax` structure containing the minimum and maximum number of digits after the decimal separator allowed as input and output.
    ///   - defaultString: The default string to return (an empty string by default).
    ///   - negative: Where to display a negative if negative values are allowed.
    /// - Returns: A string containing the formatted value for the receiving `Double` value.
    func numfoed(with maxDigits: MaxDigits, fractions: MinMax, negative: NumberFormatter.NegativePlacement = .none, default defaultString: String = "") -> String {
        return Numfo.string(for: self, maxDigits: maxDigits, fractions: fractions, negative: negative, default: defaultString)
    }
}
