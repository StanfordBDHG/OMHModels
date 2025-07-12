//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A unit value answer to a survey question
/// Generated from IEEE 1752.1 `survey-unit-value-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-unit-value-answer.json)
public struct SurveyUnitValueAnswer<UnitType: UnitProtocol>: Schema {
    /// The IEEE 1752 schema identifier
    public static var schemaId: SchemaId {
        SchemaId(namespace: .ieee, name: "survey-unit-value-answer", version: "1.0")
    }
    
    /// A unit value
    public var value: TypedUnitValue<UnitType>
    
    
    public init(value: TypedUnitValue<UnitType>) {
        self.value = value
    }
}
