//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// Errors that can occur when working with survey time answers
public enum SurveyTimeAnswerError: Error {
    case invalidTimeFormat
}

/// A time value answer to a survey question
/// Generated from IEEE 1752.1 `survey-time-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-time-answer.json)
public struct SurveyTimeAnswer: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-time-answer", version: "1.0")
    
    /// A time of day value (hours and minutes) in 24 hours format
    public var value: String
    
    
    public init(value: String) throws {
        guard value.range(of: #"^([01]\d|2[0-3]):[0-5]\d$"#, options: .regularExpression) != nil else {
            throw SurveyTimeAnswerError.invalidTimeFormat
        }
        self.value = value
    }
}
