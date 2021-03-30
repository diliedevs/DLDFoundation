//
//  CustomStringConvertibleHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension CustomStringConvertible {
    /// Returns a textual representation of this instance.
    var description: String {
        let objName = type(of: self)
        let props = Mirror(reflecting: self).children
        let propVals = props.compactMap { (arg) -> String? in
            let (label, value) = arg
            guard let name = label else { return nil }
            
            return "\t\(name): \(value)\n"
        }
        
        var desc = "\(objName) {\n"
        desc += propVals.joined()
        desc += "}"
        
        return desc
    }
}

public extension CustomStringConvertible {
    /// Returns a textual representation of this instance, suitable for debugging.
    var debugDescription: String {
        let objName = type(of: self)
        let address = Unmanaged.passRetained(self as AnyObject).toOpaque()
        let props = Mirror(reflecting: self).children
        let propVals = props.compactMap { (arg) -> String? in
            let (label, value) = arg
            guard let name = label else { return nil }
            
            return "\t\(name): \(value)\n"
        }
        
        var desc = "\(objName) <\(address)> {\n"
        desc += propVals.joined()
        desc += "}"
        
        return desc
    }
}
