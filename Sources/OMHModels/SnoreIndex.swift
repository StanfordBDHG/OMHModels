//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Units for the number of snores per hour of sleep
public enum SnoreIndexUnit: String, UnitProtocol, Hashable {
    case snoresPerHour = "snores/h"
}

/// A type representing the number of snores per hour of sleep
public typealias SnoreIndexUnitValue = TypedUnitValue<SnoreIndexUnit>

/// A time interval during which a person snored or didn't snore
public struct SnoreEvent: Codable, Hashable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case snored
        case snoreTimeFrame = "snore_time_frame"
        case snoreIntensity = "snore_intensity"
        case bodyPosture = "body_posture"
    }

    /// Whether the person snored during the time interval
    public var snored: Bool

    /// The time interval of the event
    public var snoreTimeFrame: TimeInterval

    /// The sound level of the snoring
    public var snoreIntensity: SoundUnitValue?

    /// The posture of the body during the event
    public var bodyPosture: BodyPosture?


    public init(
        snored: Bool,
        snoreTimeFrame: TimeInterval,
        snoreIntensity: SoundUnitValue? = nil,
        bodyPosture: BodyPosture? = nil
    ) {
        self.snored = snored
        self.snoreTimeFrame = snoreTimeFrame
        self.snoreIntensity = snoreIntensity
        self.bodyPosture = bodyPosture
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        snored = try container.decode(Bool.self, forKey: .snored)
        snoreTimeFrame = try container.decode(TimeInterval.self, forKey: .snoreTimeFrame)
        snoreIntensity = try container.decodeIfPresent(SoundUnitValue.self, forKey: .snoreIntensity)
        bodyPosture = try container.decodeIfPresent(BodyPosture.self, forKey: .bodyPosture)
    }
}

/// Number of snores per hour of sleep
/// Generated from IEEE 1752.1 `snore-index-1.0` (https://w3id.org/ieee/ieee-1752-schema/snore-index.json)
public struct SnoreIndex: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case snoreIndex = "snore_index"
        case snoreEvents = "snore_events"
        case effectiveTimeFrame = "effective_time_frame"
        case isMainSleep = "is_main_sleep"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "snore-index", version: "1.0")

    /// The number of snores per hour of sleep
    public var snoreIndex: SnoreIndexUnitValue

    /// The snore events. Omitted from the JSON representation when empty.
    public var snoreEvents: [SnoreEvent]

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// Whether this measurement refers to the main sleep episode of the day
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        snoreIndex: SnoreIndexUnitValue,
        effectiveTimeFrame: TimeFrame,
        snoreEvents: [SnoreEvent] = [],
        isMainSleep: Bool? = nil, // swiftlint:disable:this discouraged_optional_boolean
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.snoreIndex = snoreIndex
        self.snoreEvents = snoreEvents
        self.effectiveTimeFrame = effectiveTimeFrame
        self.isMainSleep = isMainSleep
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        snoreIndex = try container.decode(SnoreIndexUnitValue.self, forKey: .snoreIndex)
        snoreEvents = try container.decodeIfPresent([SnoreEvent].self, forKey: .snoreEvents) ?? []
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        isMainSleep = try container.decodeIfPresent(Bool.self, forKey: .isMainSleep)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(snoreIndex, forKey: .snoreIndex)
        if !snoreEvents.isEmpty {
            try container.encode(snoreEvents, forKey: .snoreEvents)
        }
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(isMainSleep, forKey: .isMainSleep)
        try container.encodeIfPresent(descriptiveStatistic, forKey: .descriptiveStatistic)
        try container.encodeIfPresent(descriptiveStatisticDenominator, forKey: .descriptiveStatisticDenominator)
    }
}
