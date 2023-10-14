//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The namespace of a schema, which serves to disambiguate schemas with conflicting names.
public enum SchemaNamespace: String, Sendable, Codable {
    case ieee
    case omh
    case granola
}
