//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The namespace of a schema, which serves to disambiguate schemas with conflicting names.
///
/// IEEE 1752 allows any string as a namespace. The namespaces used by this package are available as static properties.
public struct SchemaNamespace: RawRepresentable, Hashable, Codable, Sendable, ExpressibleByStringLiteral {
    /// The IEEE 1752 namespace.
    public static let ieee: SchemaNamespace = "ieee"
    /// The Open mHealth namespace.
    public static let omh: SchemaNamespace = "omh"
    /// The namespace of the Open mHealth HealthKit (granola) schemas.
    public static let granola: SchemaNamespace = "granola"

    public let rawValue: String


    /// Creates a value from its raw value. Never fails; failable for source compatibility with the previous `enum`.
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}
