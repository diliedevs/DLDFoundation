//
//  MaxDigits.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

/// The following constants specify what the maximum number of integer digits is that a numeric value can have.
public enum MaxDigits: Int, CaseIterable {
    /// The value has a single digit, i.e. a number under `10`.
    case single = 1
    /// The value has two digits, i.e. a number under `100`.
    case double = 2
    /// The value has three digits, i.e. a number under `1000`.
    case triple = 3
    /// The value has four digits, i.e. a number under `10.000`.
    case quadruple = 4
    /// The value has five digits, i.e. a number under `100.000`.
    case quintuple = 5
    /// The value has six digits, i.e. a number under `1.000.000`.
    case sextuple = 6
    /// The value has seven digits, i.e. a number under `10.000.000`.
    case septuple = 7
    /// The value has eight digits, i.e. a number under `100.000.000`.
    case octuple = 8
    /// The value has nine digits, i.e. a number under `1.000.000.000`.
    case nonuple = 9
    
    // MARK: - Getting a Format Width for a NumberFormatter
    /// The format width for a `NumberFormatter` according to the maximum number of integer digits.
    public var formatWidth: Int {
        return rawValue + 4
    }
}
