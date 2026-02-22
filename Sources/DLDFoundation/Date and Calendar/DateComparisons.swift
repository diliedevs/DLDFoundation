//
//  DateComparisons.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: - Date Comparisons
    /// Returns `true` if the date is in today's date.
    var isToday: Bool {
        return Calendar.autoupdatingCurrent.isDateInToday(self)
    }
    /// Returns `true` if the date is in yesterday's date.
    var isYesterday: Bool {
        return Calendar.autoupdatingCurrent.isDateInYesterday(self)
    }
    /// Returns `true` if the date is in tomorrow's date.
    var isTomorrow: Bool {
        return Calendar.autoupdatingCurrent.isDateInTomorrow(self)
    }
    /// Returns `true` if the date falls in the weekend.
    var isWeekend: Bool {
        return Calendar.autoupdatingCurrent.isDateInWeekend(self)
    }
    /// Returns `true` if the date is typically a workday or weekday.
    var isWorkday: Bool {
        return isWeekend == false
    }
    /// Returns `true` if the date is in the future, that is, after now.
    var isInFuture: Bool {
        return self > Self.now
    }
    /// Returns `true` if the date is in the past, that is, before now.
    var isInPast: Bool {
        return self < Self.now
    }
    /// Returns `true` if the date falls in the current year.
    var isThisYear: Bool {
        return isSameAs(Self.now, toGranularity: .year)
    }
    /// Returns `true` if the date falls in the current month.
    var isThisMonth: Bool {
        return isSameAs(Self.now, toGranularity: .month)
    }
    /// Returns `true` if the date falls in the current week.
    var isThisWeek: Bool {
        return isSameAs(Self.now, toGranularity: .weekOfYear)
    }
    
    /// Compares the given dates down to the given calendar component, reporting them equal if they are the same in the given component and all larger components.
    ///
    /// - parameter otherDate: The date to compare to the receiver.
    /// - parameter unit:      The smallest unit that must, along with all larger units, be equal in the dates.
    ///
    /// - returns: `true` if the two dates are equal up to the specified component (unit) of granularity.
    func isSameAs(_ otherDate: Date, toGranularity unit: CalUnit) -> Bool {
        return Calendar.autoupdatingCurrent.isDate(self, equalTo: otherDate, toGranularity: unit)
    }
}
