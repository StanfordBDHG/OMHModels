//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A code that can be used to identify a categorical answer
public enum SurveyCategoricalCode: Codable, Sendable {
    case string(String)
    case number(Double)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let numberValue = try? container.decode(Double.self) {
            self = .number(numberValue)
        } else {
            throw DecodingError.typeMismatch(
                SurveyCategoricalCode.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode SurveyCategoricalCode")
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
        }
    }
}

/// A categorical answer to a survey question
/// Generated from IEEE 1752.1 `survey-categorical-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-categorical-answer.json)
public struct SurveyCategoricalAnswer: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-categorical-answer", version: "1.0")
    
    /// The value of the answer
    public var value: SurveyAnswerValue
    
    /// A code used to identify the answer
    public var code: SurveyCategoricalCode?
    
    
    public init(value: SurveyAnswerValue, code: SurveyCategoricalCode? = nil) {
        self.value = value
        self.code = code
    }
}
