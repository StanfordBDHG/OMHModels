//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A value that can be used in a survey answer
public enum SurveyAnswerValue: Codable, Sendable {
    case string(String)
    case number(Double)
    case boolean(Bool)
    case object([String: String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let numberValue = try? container.decode(Double.self) {
            self = .number(numberValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            self = .boolean(boolValue)
        } else if let dictValue = try? container.decode([String: String].self) {
            self = .object(dictValue)
        } else {
            throw DecodingError.typeMismatch(
                SurveyAnswerValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode SurveyAnswerValue")
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .boolean(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}

/// A survey answer
/// Generated from IEEE 1752.1 `survey-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-answer.json)
public struct SurveyAnswer: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-answer", version: "1.0")
    
    /// The value of the answer
    public var value: SurveyAnswerValue
    
    
    public init(value: SurveyAnswerValue) {
        self.value = value
    }
}
