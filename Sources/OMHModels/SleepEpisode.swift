//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A sleep episode and its characteristics
/// Generated from IEEE 1752.1 `sleep-episode-1.0` (https://w3id.org/ieee/ieee-1752-schema/sleep-episode.json)
public struct SleepEpisode: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case latencyToSleepOnset = "latency_to_sleep_onset"
        case latencyToArising = "latency_to_arising"
        case totalSleepTime = "total_sleep_time"
        case lightSleepDuration = "light_sleep_duration"
        case deepSleepDuration = "deep_sleep_duration"
        case remSleepDuration = "rem_sleep_duration"
        case wakeAfterSleepOnset = "wake_after_sleep_onset"
        case numberOfAwakenings = "number_of_awakenings"
        case isMainSleep = "is_main_sleep"
        case effectiveTimeFrame = "effective_time_frame"
        case sleepEfficiencyPercentage = "sleep_efficiency_percentage"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "sleep-episode", version: "1.0")

    /// The time it took to fall asleep
    public var latencyToSleepOnset: DurationUnitValue?

    /// The time between waking up and getting out of bed
    public var latencyToArising: DurationUnitValue?

    /// The total sleep time
    public var totalSleepTime: DurationUnitValue?

    /// The duration of light sleep
    public var lightSleepDuration: DurationUnitValue?

    /// The duration of deep sleep
    public var deepSleepDuration: DurationUnitValue?

    /// The duration of REM sleep
    public var remSleepDuration: DurationUnitValue?

    /// The time spent awake after falling asleep
    public var wakeAfterSleepOnset: DurationUnitValue?

    /// The number of awakenings
    public var numberOfAwakenings: Int?

    /// Whether this measurement refers to the main sleep episode of the day
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The percentage of the time in bed spent asleep
    public var sleepEfficiencyPercentage: PercentUnitValue?


    public init(
        effectiveTimeFrame: TimeFrame,
        latencyToSleepOnset: DurationUnitValue? = nil,
        latencyToArising: DurationUnitValue? = nil,
        totalSleepTime: DurationUnitValue? = nil,
        lightSleepDuration: DurationUnitValue? = nil,
        deepSleepDuration: DurationUnitValue? = nil,
        remSleepDuration: DurationUnitValue? = nil,
        wakeAfterSleepOnset: DurationUnitValue? = nil,
        numberOfAwakenings: Int? = nil,
        isMainSleep: Bool? = nil, // swiftlint:disable:this discouraged_optional_boolean
        sleepEfficiencyPercentage: PercentUnitValue? = nil
    ) {
        self.latencyToSleepOnset = latencyToSleepOnset
        self.latencyToArising = latencyToArising
        self.totalSleepTime = totalSleepTime
        self.lightSleepDuration = lightSleepDuration
        self.deepSleepDuration = deepSleepDuration
        self.remSleepDuration = remSleepDuration
        self.wakeAfterSleepOnset = wakeAfterSleepOnset
        self.numberOfAwakenings = numberOfAwakenings
        self.isMainSleep = isMainSleep
        self.effectiveTimeFrame = effectiveTimeFrame
        self.sleepEfficiencyPercentage = sleepEfficiencyPercentage
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        latencyToSleepOnset = try container.decodeIfPresent(DurationUnitValue.self, forKey: .latencyToSleepOnset)
        latencyToArising = try container.decodeIfPresent(DurationUnitValue.self, forKey: .latencyToArising)
        totalSleepTime = try container.decodeIfPresent(DurationUnitValue.self, forKey: .totalSleepTime)
        lightSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .lightSleepDuration)
        deepSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .deepSleepDuration)
        remSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .remSleepDuration)
        wakeAfterSleepOnset = try container.decodeIfPresent(DurationUnitValue.self, forKey: .wakeAfterSleepOnset)
        numberOfAwakenings = try container.decodeIfPresent(Int.self, forKey: .numberOfAwakenings)
        isMainSleep = try container.decodeIfPresent(Bool.self, forKey: .isMainSleep)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        sleepEfficiencyPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .sleepEfficiencyPercentage)
    }
}
