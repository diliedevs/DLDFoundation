//
//  URLQueryItemHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie Sam Foek  on 12/11/2022.
//

import Foundation

extension URLQueryItem: Comparable {
    public static func < (lhs: URLQueryItem, rhs: URLQueryItem) -> Bool {
        lhs.name < rhs.name
    }
}

public extension Collection where Element == URLQueryItem {
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}

public extension Dictionary where Key == String, Value: LosslessStringConvertible {
    func toURLQueryItems() -> [URLQueryItem] {
        self.map { key, value in
            URLQueryItem(name: key, value: String(value))
        }
    }
}

public extension [URLQueryItem] {
    init<T: LosslessStringConvertible>(_ dictionary: [String: T]) {
        self = dictionary.toURLQueryItems()
    }
}
