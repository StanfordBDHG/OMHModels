//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


public enum TimeWindow: Codable, Equatable {
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
