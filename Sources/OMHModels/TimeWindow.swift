//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// Time window in which the event occurs or should occur: e.g., in twice a day every other day --> 2 times in 1 day every 2 days, time window is 1 day
/// Defined within the IEEE 1752 `frequency-unit-value-1.0` schema (https://w3id.org/ieee/ieee-1752-schema/frequency-unit-value.json)
public enum TimeWindow: Codable, Equatable, Sendable {
    case duration(DurationUnitValue)
    case durationRange(DurationUnitValueRange)
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let duration = try? container.decode(DurationUnitValue.self) {
            self = .duration(duration)
        } else if let durationRange = try? container.decode(DurationUnitValueRange.self) {
            self = .durationRange(durationRange)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    public static func == (lhs: TimeWindow, rhs: TimeWindow) -> Bool {
        switch (lhs, rhs) {
        case let (.duration(lhsDuration), .duration(rhsDuration)):
            return lhsDuration == rhsDuration
        case let (.durationRange(lhsRange), .durationRange(rhsRange)):
            return lhsRange == rhsRange
        default:
            return false
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .duration(let duration):
            try container.encode(duration)
        case .durationRange(let durationRange):
            try container.encode(durationRange)
        }
    }
}
