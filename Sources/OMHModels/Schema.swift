//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A protocol for an Open mHealth schema
public protocol Schema: Codable, Sendable {
    /// A schema identifier for an Open mHealth schema
    static var schemaId: SchemaId { get }
}
