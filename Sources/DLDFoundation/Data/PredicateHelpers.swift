//
//  PredicateHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension NSPredicate {
    // MARK: - Creating Predicates
    /// Returns a predicate that finds any object where the value for the specified key is equal to the given value.
    ///
    /// - parameter key:   The property key to check for the value.
    /// - parameter value: The value to compare to.
    ///
    /// - returns: A predicate to find any object where the value for `key` is equal to `value`.
    class func whereKey(_ key: String, isEqualTo value: Any) -> NSPredicate {
        return NSPredicate(format: "%K == %@", argumentArray: [key, value])
    }
    /// Returns a predicate that finds any object where the value for the specified key is between two given values.
    ///
    /// - parameter key:         The property key to check for the value.
    /// - parameter firstValue:  The lower of the two values it should be between.
    /// - parameter secondValue: The higher of the two values it should be between.
    ///
    /// - returns: A predicate to find any object where the value for `key` is between `firstValue` and `secondValue`.
    class func whereKey(_ key: String, isBetween firstValue: Any, and secondValue: Any) -> NSPredicate {
        return NSPredicate(format: "%K BETWEEN %@", key, [firstValue, secondValue])
    }
    /// Returns a predicate that finds any object where the value for the specified key is in the given array of values.
    /// - Parameters:
    ///   - key: The property key to check for the value.
    ///   - array: The array of values containing the value.
    class func whereKey(_ key: String, isIn array: [Any]) -> NSPredicate {
        return NSPredicate(format: "%K IN %@", key, array)
    }
    /// Returns a predicate that finds any object where the value for the specified is key is `nil` or `NULL`.
    ///
    /// - parameter key: The property key to check for a `nil` value.
    ///
    /// - returns: A predicate to find any object where the value for `key` is `nil` or `NULL`.
    class func withNilValue(for key: String) -> NSPredicate {
        return NSPredicate(format: "%K == NULL", key)
    }
    /// Returns a predicate that finds all objects.
    /// - Parameter key: Any property key to check for.
    class func withAnyValue(for key: String) -> NSPredicate {
        return NSPredicate(format: "%K != nil OR %K == nil", key, key)
    }
    
    /// Returns the predicate as a comparison predicate with left and right expressions.
    var comparisonPredicate: NSComparisonPredicate {
        return self as! NSComparisonPredicate
    }
    /// Returns the key path of the predicate.
    var keyPath: String {
        return comparisonPredicate.leftExpression.keyPath
    }
    /// Returns the value of the predicate.
    var comparisonValue: Any? {
        return comparisonPredicate.rightExpression.constantValue
    }
}
