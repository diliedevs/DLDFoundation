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
    
    /// The `Date` object at the start of today.
    static var today: Date {
        return Calendar.autoupdatingCurrent.startOfDay(for: now)
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
        return Calendar.autoupdatingCurrent.dateComponents(Set(CalUnit.all), from: self)
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
        Calendar.autoupdatingCurrent.range(of: .day, in: .month, for: self)?.count ?? 0
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
        Calendar.autoupdatingCurrent.component(comp, from: self)
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
