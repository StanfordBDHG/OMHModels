//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents the temporal relationship of a clinical measure or assessment to sleep
/// Generated from Open mHealth `omh:temporal-relationship-to-sleep:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-sleep)
public enum TemporalRelationshipToSleep: String, Schema {
    case beforeSleeping = "before sleeping"
    case duringSleep = "during sleep"
    case onWaking = "on waking"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "temporal-relationship-to-sleep", version: "1.0")
}
