//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The time spent awake after falling asleep
/// Generated from IEEE 1752.1 `wake-after-sleep-onset-1.0` (https://w3id.org/ieee/ieee-1752-schema/wake-after-sleep-onset.json)
public struct WakeAfterSleepOnset: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case wakeAfterSleepOnset = "wake_after_sleep_onset"
        case awakeningDurations = "awakening_durations"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "wake-after-sleep-onset", version: "1.0")

    /// The total time spent awake after falling asleep
    public var wakeAfterSleepOnset: DurationUnitValue

    /// The durations of the individual awakenings. Omitted from the JSON representation when empty.
    public var awakeningDurations: [DurationUnitValue]

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        wakeAfterSleepOnset: DurationUnitValue,
        effectiveTimeFrame: TimeFrame,
        awakeningDurations: [DurationUnitValue] = [],
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.wakeAfterSleepOnset = wakeAfterSleepOnset
        self.awakeningDurations = awakeningDurations
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        wakeAfterSleepOnset = try container.decode(DurationUnitValue.self, forKey: .wakeAfterSleepOnset)
        awakeningDurations = try container.decodeIfPresent([DurationUnitValue].self, forKey: .awakeningDurations) ?? []
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wakeAfterSleepOnset, forKey: .wakeAfterSleepOnset)
        if !awakeningDurations.isEmpty {
            try container.encode(awakeningDurations, forKey: .awakeningDurations)
        }
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(descriptiveStatistic, forKey: .descriptiveStatistic)
        try container.encodeIfPresent(descriptiveStatisticDenominator, forKey: .descriptiveStatisticDenominator)
    }
}
