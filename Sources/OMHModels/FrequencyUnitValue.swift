//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The frequency of an event, either in hertz or as a number of times over a duration or duration range
/// (e.g., twice a day every other day is 2 times in a time window of 1 day).
/// Generated from IEEE 1752.1 `frequency-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/frequency-unit-value.json)
public enum FrequencyUnitValue: Schema, Equatable {
    /// A frequency in hertz (cycles per second).
    case hertz(Double)
    /// How many times the event occurs or should occur in a time window.
    case timesPerTimeWindow(numberOfTimes: Double, timeWindow: TimeWindow)

    private enum CodingKeys: String, CodingKey {
        case value
        case unit
        case numberOfTimes = "number_of_times"
        case timeWindow = "time_window"
    }

    private static let hertzUnit = "Hz"

    /// The IEEE schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "frequency-unit-value", version: "1.0")


    /// How many times the event occurs or should occur in a time window.
    public init(numberOfTimes: Double, timeWindow: TimeWindow) {
        self = .timesPerTimeWindow(numberOfTimes: numberOfTimes, timeWindow: timeWindow)
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        if container.contains(.numberOfTimes) || container.contains(.timeWindow) {
            self = .timesPerTimeWindow(
                numberOfTimes: try container.decode(Double.self, forKey: .numberOfTimes),
                timeWindow: try container.decode(TimeWindow.self, forKey: .timeWindow)
            )
        } else {
            let unit = try container.decode(String.self, forKey: .unit)
            guard unit == Self.hertzUnit else {
                throw DecodingError.dataCorrupted(
                    .init(
                        codingPath: decoder.codingPath + [CodingKeys.unit],
                        debugDescription: "Unsupported frequency unit '\(unit)'; expected '\(Self.hertzUnit)'"
                    )
                )
            }
            self = .hertz(try container.decode(Double.self, forKey: .value))
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .hertz(value):
            try container.encode(value, forKey: .value)
            try container.encode(Self.hertzUnit, forKey: .unit)
        case let .timesPerTimeWindow(numberOfTimes, timeWindow):
            try container.encode(numberOfTimes, forKey: .numberOfTimes)
            try container.encode(timeWindow, forKey: .timeWindow)
        }
    }
}
