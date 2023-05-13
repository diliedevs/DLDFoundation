//
//  JSONHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 20/10/2022.
//  Copyright © 2022 DiLieDevs. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    /// Creates a new, reusable JSON encoder with the default encoding strategies and pretty printed formatting if so specified.
    /// - Parameter prettyPrinted: Set to `true` if the output formatting should use ample white space and indentation to make output easy to read.
    /// - Parameter withoutEscapingSlashes: Set to `true` if the output formatting should **not** prefix slash characters with escape characters.
    /// - Parameter sortedKeys: Set to `true` if the output formatting should sort keys in lexicographic order.
    convenience init(prettyPrinted: Bool, withoutEscapingSlashes: Bool = false, sortedKeys: Bool = false) {
        var outputFormatting = OutputFormatting()
        if prettyPrinted          { outputFormatting.update(with: .prettyPrinted) }
        if withoutEscapingSlashes { outputFormatting.update(with: .withoutEscapingSlashes) }
        if sortedKeys             { outputFormatting.update(with: .sortedKeys) }
        
        self.init()
        self.outputFormatting = outputFormatting
    }
    
    /// Returns a new, reusable JSON encoder with the default encoding strategies and pretty printed formatting.
    static var prettyPrinting: JSONEncoder {
        JSONEncoder(prettyPrinted: true)
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
    func decodeJSON<T: Decodable>(_ type: T.Type = T.self, using decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(type, from: self)
    }
    
    /// Returns a JSON-encoded representation of the value you supply.
    /// - Parameters:
    ///   - value: The value to encode as JSON.
    ///   - encoder: The JSON encoder to use to encode the supplied value.
    static func encodedJSON<T: Encodable>(_ value: T, using encoder: JSONEncoder = .prettyPrinting) throws -> Data {
        try encoder.encode(value)
    }
}

/// A type that can convert itself into JSON data or a JSON string.
public protocol JSONConvertible {
    /// The encoder to use for encoding the object into JSON data.
    var jsonEncoder : JSONEncoder { get }
    /// The data for the encoded JSON object.
    var jsonData    : Data        { get }
    /// The string representation of the JSON data.
    var json        : String      { get }
}

public extension JSONConvertible where Self: Codable {
    /// Gets the jsonEncoder, and sets it to the basic JSONEncoder with pretty printing by default.
    var jsonEncoder : JSONEncoder {
        get { .prettyPrinting }
    }
    /// Returns the codable object as JSON data.
    var jsonData: Data {
        (try? jsonEncoder.encode(self)) ?? Data()
    }
    /// Returns the json string representation of the codable object.
    var json: String {
        String(decoding: jsonData, as: UTF8.self)
    }
}

public extension UserDefaults {
    func codable<T: Codable>(forKey key: String, decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        
        do {
            return try data.decodeJSON(using: decoder)
        } catch {
            print(error)
            return nil
        }
    }
    
    func set<T: Codable>(_ codable: T, forKey key: String, encoder: JSONEncoder = JSONEncoder(prettyPrinted: true)) {
        do {
            let data = try encoder.encode(codable)
            self.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
}
