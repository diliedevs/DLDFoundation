//
//  JSONHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 20/10/2022.
//  Copyright © 2022 DiLieDevs. All rights reserved.
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

public extension JSONDecoder {
    /// Creates a new, reusable JSON decoder with the default formatting settings and the given date decoding strategy.
    /// - Parameter dateDecodingStrategy: The strategy used when decoding dates from part of a JSON object. Default is `deferredToDate`.
    convenience init(dateDecodingStrategy: DateDecodingStrategy = .deferredToDate) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}

public extension Data {
    /// Returns the data of a JSON object as a value of the type you specify using the given JSON decoder.
    /// - Parameters:
    ///   - type: The type of the value to decode from the supplied data of the JSON object.
    ///   - decoder: The JSON decoder to use to decode the JSON object.
    func decodeJSON<T: Decodable>(_ type: T.Type = T.self, using decoder: JSONDecoder) throws -> T {
        try decoder.decode(type, from: self)
    }
    
    /// Returns a JSON-encoded representation of the value you supply.
    /// - Parameters:
    ///   - value: The value to encode as JSON.
    ///   - encoder: The JSON encoder to use to encode the supplied value.
    static func encodedJSON<T: Encodable>(_ value: T, using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(value)
    }
}
