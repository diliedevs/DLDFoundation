//
//  TimeIntervalHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    // MARK: - Converting to Date Units
    /// Represents the number of seconds in the receiver.
    var seconds: TimeInterval {
        return self
    }
    /// Represents the receiving minutes as a time interval in seconds.
    var minutes: TimeInterval {
        return self * 60
    }
    /// Represents the receiving hours as a time interval in seconds.
    var hours: TimeInterval {
        return minutes * 60
    }
    /// Represents the receiving days as a time interval in seconds.
    var days: TimeInterval {
        return hours * 24
    }
    /// Represents the receiving weeks as a time interval in seconds.
    var weeks: TimeInterval {
        return days * 7
    }
    /// Represents the receiving months as an approximate time interval in seconds.
    var months: TimeInterval {
        return weeks * 4.34524
    }
    /// Represents the receiving months as an approximate time interval in seconds.
    var years: TimeInterval {
        return days * 365.25
    }
    /// Represents the number of seconds in the receiver.
    var second: TimeInterval {
        return self
    }
    /// Represents the receiving minutes as a time interval in seconds.
    var minute: TimeInterval {
        return minutes
    }
    /// Represents the receiving hours as a time interval in seconds.
    var hour: TimeInterval {
        return hours
    }
    /// Represents the receiving days as a time interval in seconds.
    var day: TimeInterval {
        return days
    }
    /// Represents the receiving weeks as a time interval in seconds.
    var week: TimeInterval {
        return weeks
    }
    /// Represents the receiving months as an approximate time interval in seconds.
    var month: TimeInterval {
        return months
    }
    /// Represents the receiving months as an approximate time interval in seconds.
    var year: TimeInterval {
        return years
    }
    
    // MARK: - Counting in Date Units
    
    /// The time interval counted in the specified `CalUnit` as a `Double`.
    ///
    /// - parameter unit: The calendar component to count the time interval in.
    ///
    /// - returns: The time interval counted in the specified `CalUnit` as a `Double`.
    func count(unit: CalUnit) -> Double {
        switch unit {
        case .minute     : return self / 1.minute
        case .hour       : return self / 1.hour
        case .day        : return self / 1.day
        case .weekOfYear : return self / 1.week
        case .month      : return self / 1.month
        case .year       : return self / 1.year
        default          : return self
        }
    }
    
    /// The time interval for 1 of the specified `CalUnit`.
    ///
    /// - parameter unit: The calendar component to return the time interval from.
    ///
    /// - returns: The time interval for 1 of the specified `unit`.
    static func one(_ unit: CalUnit) -> TimeInterval {
        switch unit {
        case .minute     : return 1.minute
        case .hour       : return 1.hour
        case .day        : return 1.day
        case .weekOfYear : return 1.week
        case .month      : return 1.month
        case .year       : return 1.year
        default          : return 1.second
        }
    }
}
