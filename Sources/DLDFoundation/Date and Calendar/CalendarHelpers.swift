//
//  CalendarHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

// MARK: - Convenience Calendar
/// The user's current calendar.
///
/// This calendar does not track changes that the user makes to their preferences.
public var curCal = Calendar.current

/// A type alias for`Calendar.Component`, an enumeration for the various components of a calendar date.
public typealias CalUnit = Calendar.Component

public extension CalUnit {
    
    // MARK: - Getting All Cases
    /// All cases of the `Calendar.Component` enumeration.
    static var all: [CalUnit] {
        return [.calendar, .day, .era, .hour, .minute, .month,
                .nanosecond, .quarter, .second, .timeZone,
                .weekOfMonth, .weekOfYear, .weekday, .weekdayOrdinal,
                .year, .yearForWeekOfYear]
    }
    
    // MARK: - Convenience Week
    /// Identifier for the week of the year unit.
    static var week: CalUnit {
        return weekOfYear
    }
}

public extension Locale {
    /// The Dutch locale identified as `nl_NL`.
    static var dutch: Locale {
        return Locale(identifier: "nl_NL")
    }
}
