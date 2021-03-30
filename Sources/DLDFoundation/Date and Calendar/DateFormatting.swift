//
//  DateFormatting.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// A type alias for `String` to represent date formats.
public typealias DateFormat = String

public extension DateFormat {
    /// Represents the string format `d-M-y`, resulting in `1-1-2001`.
    static let dMy = "d-M-y"
    /// Represents the string format `dd-MM-y`, resulting in `01-01-2001`.
    static let ddMMy = "dd-MM-y"
    /// Represents the string format `dd MMM y`, resulting in `01 Jan 2001`.
    static let ddMMMy = "dd MMM y"
    /// Represents the string format `dd MMMM y`, resulting in `01 January 2001`.
    static let ddMMMMy = "dd MMMM y"
    /// Represents the string format `d MMM y`, resulting in `1 Jan 2001`.
    static let dMMMy = "d MMM y"
    /// Represents the string format `d MMMM y`, resulting in `1 January 2001`.
    static let dMMMMy = "d MMMM y"
    /// Represents the string format `y-MM-dd`, resulting in `2001-01-01`.
    static let yMMdd = "y-MM-dd"
    /// Represents the string format `HH:mm`, resulting in `16:05`.
    static let HHmm = "HH:mm"
    /// Represents the string format `HH:mm:ss`, resulting in `16:05:05`.
    static let HHmmss = "HH:mm:ss"
}

public extension DateFormatter {
    /// A `DateFormatter` object initialized with the specified date format and locale.
    /// - Parameters:
    ///   - format: The date format string value to use.
    ///   - locale: The locale to use when setting the date format.
    ///
    /// If no locale is given, the specified date format will be used no matter what the user's preferred locale is.
    convenience init(format: DateFormat, locale: Locale? = nil) {
        self.init()
        
        if let locale = locale {
            self.locale = locale
            self.setLocalizedDateFormatFromTemplate(format)
        } else {
            self.dateFormat = format
        }
    }
}

public extension Date {
    // MARK: - Converting to Strings
    /// A string representation of the date formatted using the specified date format.
    ///
    /// - parameter format: The date format string value to use to represent the date.
    /// - parameter locale: The locale to use when setting the date format.
    ///
    /// - returns: A string representation of the date formatted using the specified `format` and `locale`.
    ///
    /// If no locale is given, the specified date format will be used no matter what the user's preferred locale is.
    func string(withFormat format: DateFormat, locale: Locale? = nil) -> String {
        return DateFormatter(format: format, locale: locale).string(from: self)
    }
    /// A string representation of the date formatted using the specified `DateFormatter.Style` date and time style.
    ///
    /// - parameter dateStyle: The predefined date style to use.
    /// - parameter timeStyle: The predefined time style to use.
    /// - parameter locale: The locale to use when creating the date formatter.
    ///
    /// - returns: A string representation of the date formatted using the specified `dateStyle` and `timeStyle`.
    func string(withDateStyle dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, locale: Locale? = nil) -> String {
        let formatter       = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        if let locale = locale { formatter.locale = locale }
        
        return formatter.string(from: self)
    }
}
