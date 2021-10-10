//
//  MirrorHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 19/06/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension Mirror {
    /// A structure representing an instance's stored property.
    struct Property: CustomStringConvertible {
        /// The name of an instance's stored property.
        public let label: String
        /// The value of an instance's stored property.
        public let value: Any
        
        /// A textual representation of an instance's stored property.
        public var description: String {
            "\(label): \(value)"
        }
        
        /// Creates an struct representing an instance's stored property with the given label and value.
        /// - Parameters:
        ///   - label: The name of the stored property.
        ///   - value: The value of the stored property.
        public init?(label: String?, value: Any) {
            guard let label = label else { return nil }
            
            self.label = label
            self.value = value
        }
    }
    
    /// A collection of all the instance's stored properties.
    var properties: [Property] {
        children.compactMap(Property.init)
    }
}
