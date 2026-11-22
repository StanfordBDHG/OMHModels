//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A value that can be used in a survey answer
public enum SurveyAnswerValue: Codable, Hashable, Sendable {
    case string(String)
    case number(Double)
    case boolean(Bool)
    case object([String: JSONValue])
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let numberValue = try? container.decode(Double.self) {
            self = .number(numberValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            self = .boolean(boolValue)
        } else if let dictValue = try? container.decode([String: JSONValue].self) {
            self = .object(dictValue)
        } else {
            throw DecodingError.typeMismatch(
                SurveyAnswerValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode SurveyAnswerValue")
            )
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
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
///
/// Survey items hold their answers as `SurveyAnswer`s. The more specific answer types (``SurveyCategoricalAnswer``, ``SurveyDateAnswer``,
/// ``SurveyTimeAnswer``, and ``SurveyUnitValueAnswer``) extend this schema and can be converted to a `SurveyAnswer`
/// without losing information, e.g., the ``code`` of a categorical answer.
/// Generated from IEEE 1752.1 `survey-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-answer.json)
public struct SurveyAnswer: Schema, Hashable {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-answer", version: "1.0")
    
    /// The value of the answer
    public var value: SurveyAnswerValue

    /// The code of the answer, if this is a categorical answer (see ``SurveyCategoricalAnswer``)
    public var code: SurveyCategoricalCode?
    
    
    public init(value: SurveyAnswerValue, code: SurveyCategoricalCode? = nil) {
        self.value = value
        self.code = code
    }

    /// Creates a survey answer from a categorical answer, keeping its code.
    public init(_ answer: SurveyCategoricalAnswer) {
        self.init(value: answer.value, code: answer.code)
    }

    /// Creates a survey answer from a date answer.
    public init(_ answer: SurveyDateAnswer) {
        self.init(value: .string(answer.value.stringValue))
    }

    /// Creates a survey answer from a time answer.
    public init(_ answer: SurveyTimeAnswer) {
        self.init(value: .string(answer.value))
    }

    /// Creates a survey answer from a unit value answer.
    public init<UnitType>(_ answer: SurveyUnitValueAnswer<UnitType>) throws {
        guard case let .object(object) = try JSONValue(encoding: answer.value) else {
            throw EncodingError.invalidValue(
                answer.value,
                .init(codingPath: [], debugDescription: "A unit value must encode to a JSON object")
            )
        }
        self.init(value: .object(object))
    }
}
