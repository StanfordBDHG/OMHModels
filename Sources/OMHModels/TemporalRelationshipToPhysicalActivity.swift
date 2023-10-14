//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// This schema represents the temporal relationship of a clinical measure or assessment to physical activity (e.g., at rest, during exercise).
/// Generated from Open mHealth `omh:temporal-relationship-to-physical-activity:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-physical-activity)
public enum TemporalRelationshipToPhysicalActivity: String, Schema {
    case atRest = "at rest"
    case active
    case beforeExercise = "before exercise"
    case afterExercise = "after exercise"
    case duringExercise = "during exercise"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "temporal-relationship-to-physical-activity", version: "1.0")
}
