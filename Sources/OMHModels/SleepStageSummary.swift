//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A sleep stage
public enum SleepStageState: String, Codable, Hashable, Sendable {
    case rem = "REM_sleep"
    case light = "Light_sleep"
    case deep = "Deep_sleep"
    case unknown = "Unknown_sleep"
    case awake = "Awake"
}

/// The durations, counts, and percentages of the sleep stages in a sleep stage summary
public struct SleepStageSummaryDetails: Codable, Hashable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case totalSleepTime = "total_sleep_time"
        case sleepEfficiencyPercentage = "sleep_efficiency_percentage"
        case latencyToSleepOnset = "latency_to_sleep_onset"
        case latencyToArising = "latency_to_arising"
        case remSleepDuration = "rem_sleep_duration"
        case remSleepEpisodeCount = "rem_sleep_episode_count"
        case remSleepPercentage = "rem_sleep_percentage"
        case lightSleepDuration = "light_sleep_duration"
        case lightSleepEpisodeCount = "light_sleep_episode_count"
        case lightSleepPercentage = "light_sleep_percentage"
        case deepSleepDuration = "deep_sleep_duration"
        case deepSleepEpisodeCount = "deep_sleep_episode_count"
        case deepSleepPercentage = "deep_sleep_percentage"
        case awakeDuration = "awake_duration"
        case numberOfAwakenings = "number_of_awakenings"
        case awakePercentage = "awake_percentage"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The total sleep time
    public var totalSleepTime: DurationUnitValue

    /// The percentage of the time in bed spent asleep
    public var sleepEfficiencyPercentage: PercentUnitValue?

    /// The time it took to fall asleep
    public var latencyToSleepOnset: DurationUnitValue?

    /// The time between waking up and getting out of bed
    public var latencyToArising: DurationUnitValue?

    /// The duration of REM sleep
    public var remSleepDuration: DurationUnitValue?

    /// The number of REM sleep episodes
    public var remSleepEpisodeCount: Int?

    /// The percentage of the total sleep time spent in REM sleep
    public var remSleepPercentage: PercentUnitValue?

    /// The duration of light sleep
    public var lightSleepDuration: DurationUnitValue?

    /// The number of light sleep episodes
    public var lightSleepEpisodeCount: Int?

    /// The percentage of the total sleep time spent in light sleep
    public var lightSleepPercentage: PercentUnitValue?

    /// The duration of deep sleep
    public var deepSleepDuration: DurationUnitValue?

    /// The number of deep sleep episodes
    public var deepSleepEpisodeCount: Int?

    /// The percentage of the total sleep time spent in deep sleep
    public var deepSleepPercentage: PercentUnitValue?

    /// The time spent awake
    public var awakeDuration: DurationUnitValue?

    /// The number of awakenings
    public var numberOfAwakenings: Int?

    /// The percentage of the time spent awake
    public var awakePercentage: PercentUnitValue?

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        totalSleepTime: DurationUnitValue,
        sleepEfficiencyPercentage: PercentUnitValue? = nil,
        latencyToSleepOnset: DurationUnitValue? = nil,
        latencyToArising: DurationUnitValue? = nil,
        remSleepDuration: DurationUnitValue? = nil,
        remSleepEpisodeCount: Int? = nil,
        remSleepPercentage: PercentUnitValue? = nil,
        lightSleepDuration: DurationUnitValue? = nil,
        lightSleepEpisodeCount: Int? = nil,
        lightSleepPercentage: PercentUnitValue? = nil,
        deepSleepDuration: DurationUnitValue? = nil,
        deepSleepEpisodeCount: Int? = nil,
        deepSleepPercentage: PercentUnitValue? = nil,
        awakeDuration: DurationUnitValue? = nil,
        numberOfAwakenings: Int? = nil,
        awakePercentage: PercentUnitValue? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.totalSleepTime = totalSleepTime
        self.sleepEfficiencyPercentage = sleepEfficiencyPercentage
        self.latencyToSleepOnset = latencyToSleepOnset
        self.latencyToArising = latencyToArising
        self.remSleepDuration = remSleepDuration
        self.remSleepEpisodeCount = remSleepEpisodeCount
        self.remSleepPercentage = remSleepPercentage
        self.lightSleepDuration = lightSleepDuration
        self.lightSleepEpisodeCount = lightSleepEpisodeCount
        self.lightSleepPercentage = lightSleepPercentage
        self.deepSleepDuration = deepSleepDuration
        self.deepSleepEpisodeCount = deepSleepEpisodeCount
        self.deepSleepPercentage = deepSleepPercentage
        self.awakeDuration = awakeDuration
        self.numberOfAwakenings = numberOfAwakenings
        self.awakePercentage = awakePercentage
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        totalSleepTime = try container.decode(DurationUnitValue.self, forKey: .totalSleepTime)
        sleepEfficiencyPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .sleepEfficiencyPercentage)
        latencyToSleepOnset = try container.decodeIfPresent(DurationUnitValue.self, forKey: .latencyToSleepOnset)
        latencyToArising = try container.decodeIfPresent(DurationUnitValue.self, forKey: .latencyToArising)
        remSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .remSleepDuration)
        remSleepEpisodeCount = try container.decodeIfPresent(Int.self, forKey: .remSleepEpisodeCount)
        remSleepPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .remSleepPercentage)
        lightSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .lightSleepDuration)
        lightSleepEpisodeCount = try container.decodeIfPresent(Int.self, forKey: .lightSleepEpisodeCount)
        lightSleepPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .lightSleepPercentage)
        deepSleepDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .deepSleepDuration)
        deepSleepEpisodeCount = try container.decodeIfPresent(Int.self, forKey: .deepSleepEpisodeCount)
        deepSleepPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .deepSleepPercentage)
        awakeDuration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .awakeDuration)
        numberOfAwakenings = try container.decodeIfPresent(Int.self, forKey: .numberOfAwakenings)
        awakePercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .awakePercentage)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }
}

/// A time interval spent in a sleep stage
public struct SleepStageEpisode: Codable, Hashable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case sleepStageState = "sleep_stage_state"
        case sleepStageTimeFrame = "sleep_stage_time_frame"
    }

    /// The sleep stage
    public var sleepStageState: SleepStageState

    /// The time interval spent in the sleep stage
    public var sleepStageTimeFrame: TimeFrame


    public init(
        sleepStageState: SleepStageState,
        sleepStageTimeFrame: TimeFrame
    ) {
        self.sleepStageState = sleepStageState
        self.sleepStageTimeFrame = sleepStageTimeFrame
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        sleepStageState = try container.decode(SleepStageState.self, forKey: .sleepStageState)
        sleepStageTimeFrame = try container.decode(TimeFrame.self, forKey: .sleepStageTimeFrame)
    }
}

/// A summary of the sleep stages of a sleep episode
/// Generated from IEEE 1752.1 `sleep-stage-summary-1.0` (https://w3id.org/ieee/ieee-1752-schema/sleep-stage-summary.json)
public struct SleepStageSummary: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case sleepStageSummary = "sleep_stage_summary"
        case sleepStageEpisodes = "sleep_stage_episodes"
        case effectiveTimeFrame = "effective_time_frame"
        case isMainSleep = "is_main_sleep"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "sleep-stage-summary", version: "1.0")

    /// The durations, counts, and percentages of the sleep stages
    public var sleepStageSummary: SleepStageSummaryDetails

    /// The individual sleep stage episodes. Omitted from the JSON representation when empty.
    public var sleepStageEpisodes: [SleepStageEpisode]

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// Whether this measurement refers to the main sleep episode of the day
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean


    public init(
        sleepStageSummary: SleepStageSummaryDetails,
        effectiveTimeFrame: TimeFrame,
        sleepStageEpisodes: [SleepStageEpisode] = [],
        isMainSleep: Bool? = nil // swiftlint:disable:this discouraged_optional_boolean
    ) {
        self.sleepStageSummary = sleepStageSummary
        self.sleepStageEpisodes = sleepStageEpisodes
        self.effectiveTimeFrame = effectiveTimeFrame
        self.isMainSleep = isMainSleep
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        sleepStageSummary = try container.decode(SleepStageSummaryDetails.self, forKey: .sleepStageSummary)
        sleepStageEpisodes = try container.decodeIfPresent([SleepStageEpisode].self, forKey: .sleepStageEpisodes) ?? []
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        isMainSleep = try container.decodeIfPresent(Bool.self, forKey: .isMainSleep)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sleepStageSummary, forKey: .sleepStageSummary)
        if !sleepStageEpisodes.isEmpty {
            try container.encode(sleepStageEpisodes, forKey: .sleepStageEpisodes)
        }
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(isMainSleep, forKey: .isMainSleep)
    }
}
