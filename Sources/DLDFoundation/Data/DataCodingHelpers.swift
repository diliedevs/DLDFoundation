//
//  DataCodingHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    /// Creates a new, reusable JSON encoder with the default encoding strategies and a pretty printed formatting if so specified.
    /// - Parameter prettyPrinted: Set to `true` if the output formatting should use ample white space and indentation to make output easy to read.
    convenience init(prettyPrinted: Bool) {
        self.init()
        if prettyPrinted {
            self.outputFormatting = .prettyPrinted
        }
    }
}

public extension PropertyListEncoder {
    /// Creates a new, reusable property list encoder with xml formatting if so specified.
    /// - Parameter xmlFormat: Set to `true` if the output format should be in the XML property list format.
    convenience init(xmlFormat: Bool) {
        self.init()
        if xmlFormat {
            self.outputFormat = .xml
        }
    }
}

public extension Data {
    func jsonDecode<T: Decodable>(_ type: T.Type = T.self, using decoder: JSONDecoder) throws -> T {
        try decoder.decode(type, from: self)
    }
    
    func plistDecode<T: Decodable>(_ type: T.Type = T.self, using decoder: PropertyListDecoder) throws -> T {
        return try decoder.decode(type, from: self)
    }
    
    static func jsonEncoded<T: Encodable>(_ value: T, using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(value)
    }
    
    static func plistEncoded<T: Encodable>(_ value: T, using encoder: PropertyListEncoder) throws -> Data {
        try encoder.encode(value)
    }
}
