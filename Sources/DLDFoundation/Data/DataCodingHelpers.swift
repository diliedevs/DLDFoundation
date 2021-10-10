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
//
//public extension DecodingError {
//    var cause: String {
//        switch self {
//        case .keyNotFound(let key, _): return "missing key '\(key.stringValue)'"
//        case .typeMismatch(let type, _): return "type mismatch of '\(type)'"
//        case .valueNotFound(let type, _): return "missing \(type) value"
//        case .dataCorrupted(_): return "invalid file format"
//        case _: return localizedDescription
//        }
//    }
//
//    func message(using file: String) -> String {
//        "Failed to decode \(file) due to \(cause)"
//    }
//}

//public extension EncodingError {
//    var cause: String {
//        switch self {
//        case .invalidValue(let value, _): return "invalid value of \(value)"
//        case _: return localizedDescription
//        }
//    }
//    
//    func message(using file: String) -> String {
//        "Failed to encode \(file) due to \(cause)"
//    }
//}

public extension Data {
    func jsonDecode<T: Decodable>(_ type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: self)
    }
    
    func plistDecode<T: Decodable>(_ type: T.Type) throws -> T {
        let decoder = PropertyListDecoder()
        return try decoder.decode(type, from: self)
    }
    
    static func jsonEncoded<T: Encodable>(_ value: T, prettyPrinted: Bool = true) throws -> Data {
        let encoder = JSONEncoder(prettyPrinted: prettyPrinted)
        return try encoder.encode(value)
    }
    
    static func plistEncoded<T: Encodable>(_ value: T) throws -> Data {
        let encoder = PropertyListEncoder(xmlFormat: true)
        return try encoder.encode(value)
    }
}
