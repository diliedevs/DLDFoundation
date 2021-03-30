//
//  DateInitializers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Date {
    // MARK: - Creating Date Objects
    
    /// A `Date` object initialized with the specified `DateComponents` object.
    ///
    /// - parameter components: A `DateComponents` object specifying the temporal components that make up a date and time.
    ///
    /// - returns: A `Date` object initialized with the specified `DateComponents` object or the current date and time if the components could not be converted into a `Date` object.
    init(components: DateComponents) {
        if let date = curCal.date(from: components) {
            self = date
        } else {
            self.init()
        }
    }
    
    /// A `Date` object initialized with the specified date and time components.
    ///
    /// - parameter year:   The number of year units.
    /// - parameter month:  The number of month units.
    /// - parameter day:    The number of day units.
    /// - parameter hour:   The number of hour units.
    /// - parameter minute: The number of minute units.
    /// - parameter second: The number of second units.
    ///
    /// - returns: A `Date` object initialized with the specified date and time components or the current date and time if the components could not be converted into a `Date` object.
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        self.init(components: components)
    }
    
    /// A `Date` object initialized with the specified date components.
    ///
    /// - parameter year:   The number of year units.
    /// - parameter month:  The number of month units.
    /// - parameter day:    The number of day units.
    ///
    /// - returns: A `Date` object initialized with the specified date components or the current date and time if the components could not be converted into a `Date` object.
    init(year: Int, month: Int, day: Int) {
        let components = DateComponents(year: year, month: month, day: day)
        self.init(components: components)
    }
    
    /// A `Date` object initialized with the specified time components.
    ///
    /// - parameter hour:   The number of hour units.
    /// - parameter minute: The number of minute units.
    /// - parameter second: The number of second units.
    ///
    /// - returns: A `Date` object initialized with the specified time components or the current date and time if the components could not be converted into a `Date` object.
    init(hour: Int, minute: Int, second: Int) {
        let components = DateComponents(hour: hour, minute: minute, second: second)
        self.init(components: components)
    }
    
    /// A `Date` object initialized with the specified hour and minute components.
    ///
    /// - Parameters:
    ///   - hour: The number of hour units.
    ///   - minute: The number of minute units.
    init(hour: Int, minute: Int)  {
        self.init(hour: hour, minute: minute, second: 0)
    }
    
    /// A `Date` object initialized with the specified hour component.
    ///
    /// - parameter hour: The number of hour units.
    init(hour: Int) {
        self.init(hour: hour, minute: 0, second: 0)
    }
    
    /// A `Date` object initialized from the specified string using the specified `DateFormatter`.
    ///
    /// - parameter string:    The string representing the date and/or time value.
    /// - parameter formatter: The `DateFormatter` to use in converting the `string`.
    ///
    /// - returns: a `Date` object initialized from the specified string using the specified `DateFormatter` or the current date and time if the `string` could not be parsed into a `Date` object.
    init(string: String, formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else {
            self.init()
            return
        }
        
        self.init(components: date.components)
    }
    
    /// A `Date` object initialized from the specified string using a `DateFormatter` with the specified `DateFormat`.
    ///
    /// - parameter string:    The string representing the date and/or time value.
    /// - parameter dateFormat: The date format string to use in converting the `string`.
    ///
    /// - returns: a `Date` object initialized from the specified string using the specified `DateFormatter` or the current date and time if the `string` could not be parsed into a `Date` object.
    init(string: String, dateFormat: DateFormat) {
        self.init(string: string, formatter: DateFormatter(format: dateFormat))
    }
}
