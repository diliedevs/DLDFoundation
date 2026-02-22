//
//  ModelProtocols.swift
//  DLDFoundation
//
//  Created by Dionne Lie Sam Foek on 21/02/2026.
//  Copyright © 2026 DiLieDevs. All rights reserved.
//

import Foundation

/// A composite protocol type alias that standardizes fundamental model requirements across the codebase.
///
/// Conforming types must:
/// - Be encodable and decodable (`Codable`) to support persistence and data exchange,
///   such as JSON serialization and deserialization.
/// - Provide a stable and unique identity (`Identifiable`) for use in lists, diffing,
///   and state management.
/// - Be hashable (`Hashable`) to enable usage in hashed collections like `Set` and
///   as dictionary keys, and to support efficient comparisons.
///
/// Use `Model` for value types (e.g., `struct`) that represent domain entities or
/// data transfer objects that need to be uniquely identified, serialized, and stored.
///
/// Example conformance:
/// ```swift
/// struct User: Model {
///     let id: UUID
///     let name: String
/// }
/// ```
///
/// Notes:
/// - Ensure the `id` used for `Identifiable` is stable across encodes/decodes if the
///   instance identity must be preserved.
/// - When adding reference types (`class`) as models, consider thread-safety and
///   value semantics implications with `Hashable`.
public typealias Model = Codable & Identifiable & Hashable

/// A composite protocol type alias for enumeration-based models that standardizes
/// fundamental requirements across the codebase.
///
/// Conforming types must:
/// - Be an enumeration that exposes all of its cases (`CaseIterable`) for iteration,
///   UI generation, and validation.
/// - Conform to `Model`, meaning they are `Codable`, `Identifiable`, and `Hashable`,
///   enabling serialization, stable identity, and usage in hashed collections.
///
/// Use `ModelEnum` for enums that represent finite domain concepts (e.g., status,
/// category, or mode) which must be uniquely identifiable and serializable.
///
/// Example:
/// ```swift
/// enum Status: ModelEnum {
///     case pending, active, suspended
///
///     var id: Self { self } // Satisfies Identifiable by using the case itself
/// }
/// ```
///
/// Notes:
/// - For `Identifiable`, consider using `Self` as `ID` when cases are unique and stable:
///   `var id: Self { self }`.
/// - If cases carry associated values, ensure they remain encodable/decodable and that
///   hashing and identity reflect the intended semantics.
/// - `CaseIterable` is only automatically synthesized for enums without associated values.
///   For enums with associated values, you must provide a custom `allCases` implementation.
public typealias ModelEnum = CaseIterable & Model
