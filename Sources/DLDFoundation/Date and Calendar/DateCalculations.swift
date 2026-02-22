//
//  DateCalculations.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Date {
    
    // MARK: - Changing Date Component Values
    /// Changes the specified date components to the given values and The new date.
    ///
    /// - parameter unitValues: An dictionary of `CalUnit` or `Calendar.Component` keys and the integer values the components should be set to.
    ///
    /// - returns: The new date after changing the date to the specified date components and their given values.
    func changing(_ unitValues: [CalUnit: Int]) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var comps = components
        for (unit, value) in unitValues {
            comps.setValue(value, for: unit)
        }
        
        return calendar.date(from: comps) ?? self
    }
    
    // MARK: - Calculating Time Intervals
    /// The interval between the date and another given date as a `Double` in the specified `CalUnit`.
    ///
    /// - parameter unit: The calendar component to calculate between dates.
    /// - parameter date: The date with which to calculate the interval.
    ///
    /// - returns: The interval between the date and another given date as a `Double` in the specified `CalUnit`.
    func preciseCount(of unit: CalUnit, toDate date: Date) -> Double {
        let interval = date.timeIntervalSince(self)
        let calendar = Calendar.autoupdatingCurrent
        let countedUnit = unit == .week ? .weekOfYear : unit

        if [.second, .minute, .hour, .day, .weekOfYear, .month, .year].contains(countedUnit) {
            return interval.count(unit: countedUnit)
        }

        let value = calendar.dateComponents([countedUnit], from: self, to: date).value(for: countedUnit) ?? 0
        return Double(value)
    }
    /// The interval between the date and another given date as an `Int` in the specified `CalUnit`.
    ///
    /// - parameter unit: The calendar component to calculate between dates.
    /// - parameter date: The date with which to calculate the interval.
    ///
    /// - returns: The interval between the date and another given date as an `Int` in the specified `CalUnit`.
    func count(of unit: CalUnit, toDate date: Date) -> Int {
        return Int(preciseCount(of: unit, toDate: date))
    }
    
    // MARK: - Date Calculations
    /// A new `Date` object that is set to the start of the specified `CalUnit` of the date.
    ///
    /// - parameter unit: The calendar component and all smaller units to get the start of.
    ///
    /// - returns: A new `Date` object that is set to the start of `unit` of the date.
    func start(of unit: CalUnit) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let intervalUnit = unit == .week ? .weekOfYear : unit
        
        if let start = calendar.dateInterval(of: intervalUnit, for: self)?.start {
            return start
        }
        
        switch unit {
        case .second     : return changing([.nanosecond: 0])
        case .minute     : return changing([.nanosecond: 0, .second: 0])
        case .hour       : return changing([.nanosecond: 0, .second: 0, .minute: 0])
        case .day        : return changing([.nanosecond: 0, .second: 0, .minute: 0, .hour: 0])
        case .month      : return changing([.nanosecond: 0, .second: 0, .minute: 0, .hour: 0, .day: 1])
        case .year       : return changing([.nanosecond: 0, .second: 0, .minute: 0, .hour: 0, .day: 1, .month: 1])
        default          : return self
        }
    }
    
    /// A new `Date` object that is set to the end of the specified `CalUnit` of the date.
    ///
    /// - parameter unit: The calendar component and all smaller units to get the end of.
    ///
    /// - returns: A new `Date` object that is set to the end of `unit` of the date.
    func end(of unit: CalUnit) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let intervalUnit = unit == .week ? .weekOfYear : unit
        if let interval = calendar.dateInterval(of: intervalUnit, for: self) {
            return interval.end - 1.second
        }
        
        return next(unit: unit).start(of: unit) - 1.second
    }
    
    /// A new `Date` object that is set to the next specified `CalUnit` of the date.
    ///
    /// - parameter unit: The calendar component to get the next date of.
    ///
    /// - returns: A new `Date` object that is set to the next specified `unit` of the date.
    func next(unit: CalUnit) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let countedUnit = unit == .week ? .weekOfYear : unit
        return calendar.date(byAdding: countedUnit, value: 1, to: self) ?? self
    }
    
    /// A new `Date` object that is set to the previous specified `CalUnit` of the date.
    ///
    /// - parameter unit: The calendar component to get the previous date of.
    ///
    /// - returns: A new `Date` object that is set to the previous specified `unit` of the date.
    func previous(unit: CalUnit) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let countedUnit = unit == .week ? .weekOfYear : unit
        return calendar.date(byAdding: countedUnit, value: -1, to: self) ?? self
    }
}
