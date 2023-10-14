//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A schema identifier
/// Generated from IEEE 1752.1`schema-id-1.0` (https://w3id.org/ieee/ieee-1752-schema/schema-id.json)
public struct SchemaId: Sendable, Codable, Equatable {
    /// The namespace of the schema. A namespace serves to disambiguate schemas with conflicting names.
    public var namespace: SchemaNamespace

    /// The name of the schema.
    public var name: String

    /// The version of the schema.
    public var version: String
    
    
    public init (
        namespace: SchemaNamespace,
        name: String,
        version: String
    ) {
        self.namespace = namespace
        self.name = name
        self.version = version
    }
    
    public static func == (lhs: SchemaId, rhs: SchemaId) -> Bool {
        lhs.namespace == rhs.namespace &&
        lhs.name == rhs.name &&
        lhs.version == rhs.version
    }
}
