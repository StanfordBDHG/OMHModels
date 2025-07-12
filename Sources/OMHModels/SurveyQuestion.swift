//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A survey question
/// Generated from IEEE 1752.1 `survey-question-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-question.json)
public struct SurveyQuestion: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-question", version: "1.0")
    
    /// The text of the question
    public var text: String
    
    /// A label used to identify the question
    public var label: String?
    
    
    public init(text: String, label: String? = nil) {
        self.text = text
        self.label = label
    }
}
