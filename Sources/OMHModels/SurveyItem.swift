//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A survey item, i.e., the combination of a question and the list of its answers
/// Generated from IEEE 1752.1 `survey-item-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-item.json)
public struct SurveyItem: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-item", version: "1.0")
    
    /// The question being asked
    public var question: SurveyQuestion
    
    /// A list of answers to the question. This list is empty if the question isn't answered, and may have multiple elements if more than one answer is provided
    public var answers: [SurveyAnswer]
    
    /// The date time at which this item was presented to the participant
    public var askedDateTime: DateTime?
    
    /// The date time at which the answer was provided. If multiple answers are provided, the suggestion is to use the last answer's date time
    public var answeredDateTime: DateTime?
    
    
    public init(question: SurveyQuestion, answers: [SurveyAnswer] = [], askedDateTime: DateTime? = nil, answeredDateTime: DateTime? = nil) {
        self.question = question
        self.answers = answers
        self.askedDateTime = askedDateTime
        self.answeredDateTime = answeredDateTime
    }
}
