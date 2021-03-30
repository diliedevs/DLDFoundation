//
//  OptionalHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Optional {
    /// Returns `true` if the optional is `nil`.
    var isNil: Bool {
        return self == nil
    }
    /// Returns `true` if the optional is *not* `nil`.
    var isNotNil: Bool {
        return isNil == false
    }
}

public extension Optional where Wrapped: Collection {
    /// Returns `true` if the optional collection is `nil` or if it is empty.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    /// Returns `true` if the optional collection is *not* `nil` or empty.
    var isNotNilOrEmpty: Bool {
        return isNilOrEmpty == false
    }
}
