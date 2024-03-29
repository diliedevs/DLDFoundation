//
//  DateVariables.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Date {
    // MARK: - Common Date Indicators
    
    /// The current date and time.
    @available(macOS, obsoleted: 12, message: "Swift now has this same static property.")
    @available(iOS, obsoleted: 15, message: "Swift now has this same static property.")
    static var now: Date {
        return Date()
    }
    /// The `Date` object at the start of today.
    static var today: Date {
        return curCal.startOfDay(for: now)
    }
    /// The week number for today's date.
    static var thisWeek: Int {
        return today.week
    }
    /// The month for today's date.
    static var thisMonth: Int {
        return today.month
    }
    /// The year for today's date.
    static var thisYear: Int {
        return today.year
    }
    
    // MARK: - Getting Date Components
    /// All components of the `Date` object.
    var components: DateComponents {
        return curCal.dateComponents(Set(CalUnit.all), from: self)
    }
    /// The year of the date object.
    var year: Int {
        return component(.year)
    }
    /// The month of the date object.
    var month: Int {
        return component(.month)
    }
    /// The day of the date object.
    var day: Int {
        return component(.day)
    }
    /// The hour of the date object.
    var hour: Int {
        return component(.hour)
    }
    /// The minute of the date object.
    var minute: Int {
        return component(.minute)
    }
    /// The second of the date object.
    var second: Int {
        return component(.second)
    }
    /// The weekday of the date object.
    var weekday: Int {
        return component(.weekday)
    }
    /// The week of the date object.
    var week: Int {
        return component(.weekOfYear)
    }
    /// The number of days in the month of the date object.
    var daysInMonth: Int {
        if let count = curCal.range(of: .day, in: .month, for: self)?.count {
            return count
        } else {
            if month == 2 {
                return year.isMultiple(of: 4) ? 29 : 28
            } else {
                return [4, 6, 9, 11].contains(month) ? 30 : 31
            }
        }
    }
    
    /// Returns `true` if the date is in the distant past in terms of centuries.
    var isDistantPast: Bool {
        self == .distantPast
    }
    /// Returns `true` if the date is in the distant future in terms of centuries.
    var isDistantFuture: Bool {
        self == .distantFuture
    }
    /// Returns `true` if the date is in the distant past or future in terms of centuries.
    var isDistant: Bool {
        isDistantPast || isDistantFuture
    }
    
    // MARK: - Converting to NSDate
    /// The date as an `NSDate` object.
    var ns: NSDate {
        return self as NSDate
    }
}

fileprivate extension Date {
    func component(_ comp: Calendar.Component) -> Int {
        curCal.component(comp, from: self)
    }
}

public extension NSDate {
    
    // MARK: - Converting to Date
    /// The `NSDate` as a `Date` object.
    var date: Date {
        return self as Date
    }
}

public extension Int {
    // MARK: - Common Date Components
    /// The week number for today's date.
    static var thisWeek: Int {
        Date.thisWeek
    }
    /// The month for today's date.
    static var thisMonth: Int {
        Date.thisMonth
    }
    /// The year for today's date.
    static var thisYear: Int {
        Date.thisYear
    }
}
