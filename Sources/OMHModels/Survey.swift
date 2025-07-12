//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The operational details of delivering a survey
public struct SurveyDeliveryDetails: Codable, Sendable {
    /// The date time at which this survey was started
    public var startDateTime: DateTime?
    
    /// The date time at which this survey was finished (not necessarily completed)
    public var endDateTime: DateTime?
    
    /// The way this survey was ended by the participant
    public var endStatus: SurveyEndStatus?
    
    
    public init(startDateTime: DateTime? = nil, endDateTime: DateTime? = nil, endStatus: SurveyEndStatus? = nil) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.endStatus = endStatus
    }
}

/// The way a survey was ended by the participant
public enum SurveyEndStatus: String, Codable, Sendable {
    /// Survey was completed successfully
    case completed
    /// Survey was abandoned (some answers were provided)
    case abandoned
    /// Survey was missed (no answers were provided)
    case missed
}

/// A score calculated for a survey
public enum SurveyScore: Codable, Sendable {
    case number(Double)
    case object([String: String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let numberValue = try? container.decode(Double.self) {
            self = .number(numberValue)
        } else if let dictValue = try? container.decode([String: String].self) {
            self = .object(dictValue)
        } else {
            throw DecodingError.typeMismatch(
                SurveyScore.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode SurveyScore")
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .number(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}

/// A survey as an array of at least one survey item (the combination of a question and the list of answers)
/// Generated from IEEE 1752.1 `survey-1.0` (https://w3id.org/ieee/ieee-1752-schema/survey.json)
public struct Survey: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "survey", version: "1.0")
    
    /// The list of questions and answers that make up this survey
    public var items: [SurveyItem]
    
    /// The operational details of delivering this survey
    public var deliveryDetails: SurveyDeliveryDetails
    
    /// The score calculated for the survey: this can be a number or a combination of numbers and/or string
    public var score: SurveyScore?
    
    
    public init(items: [SurveyItem], deliveryDetails: SurveyDeliveryDetails, score: SurveyScore? = nil) {
        self.items = items
        self.deliveryDetails = deliveryDetails
        self.score = score
    }
}
