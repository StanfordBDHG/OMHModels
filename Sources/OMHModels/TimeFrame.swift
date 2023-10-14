//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Enables a particular time frame to be described as either a point in time or a time interval.
/// Generated from IEEE 1752.1 `time-frame-1.0` (https://w3id.org/ieee/ieee-1752-schema/time-frame.json)
public struct TimeFrame: Schema, Equatable {
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case timeInterval = "time_interval"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "time-frame", version: "1.0")
    
    public let dateTime: DateTime?
    
    public let timeInterval: TimeInterval?


    public init(dateTime: DateTime) {
        self.dateTime = dateTime
        self.timeInterval = nil
    }

    public init(timeInterval: TimeInterval) {
        self.dateTime = nil
        self.timeInterval = timeInterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
        timeInterval = try container.decodeIfPresent(TimeInterval.self, forKey: .timeInterval)
        guard dateTime != nil || timeInterval != nil else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "Invalid time frame data")
            )
        }
    }

    public static func == (lhs: TimeFrame, rhs: TimeFrame) -> Bool {
        lhs.dateTime == rhs.dateTime && lhs.timeInterval == rhs.timeInterval
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let dateTime = dateTime {
            try container.encode(dateTime, forKey: .dateTime)
        } else if let timeInterval = timeInterval {
            try container.encode(timeInterval, forKey: .timeInterval)
        }
    }
}
