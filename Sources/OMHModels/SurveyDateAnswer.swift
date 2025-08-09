//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A date value that can be full or partial
public enum SurveyDateValue: Codable, Sendable {
    case fullDate(String)    // YYYY-MM-DD
    case yearMonth(String)   // YYYY-MM
    case yearOnly(String)    // YYYY
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        
        if stringValue.range(of: #"^[0-9]{4}-[0-9]{2}-[0-9]{2}$"#, options: .regularExpression) != nil {
            self = .fullDate(stringValue)
        } else if stringValue.range(of: #"^[0-9]{4}-[0-9]{2}$"#, options: .regularExpression) != nil {
            self = .yearMonth(stringValue)
        } else if stringValue.range(of: #"^[0-9]{4}$"#, options: .regularExpression) != nil {
            self = .yearOnly(stringValue)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .fullDate(let value),
             .yearMonth(let value),
             .yearOnly(let value):
            try container.encode(value)
        }
    }
}

/// A date value answer to a survey question
/// Generated from IEEE 1752.1 `survey-date-answer-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey-date-answer.json)
public struct SurveyDateAnswer: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey-date-answer", version: "1.0")
    
    /// A date value (full or partial)
    public var value: SurveyDateValue
    
    
    public init(value: SurveyDateValue) {
        self.value = value
    }
}
