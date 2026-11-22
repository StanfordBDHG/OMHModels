//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The duration of deep sleep
/// Generated from IEEE 1752.1 `deep-sleep-1.0` (https://w3id.org/ieee/ieee-1752-schema/deep-sleep.json)
public struct DeepSleep: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case deepSleepDuration = "deep_sleep_duration"
        case totalSleepTime = "total_sleep_time"
        case deepSleepPercentage = "deep_sleep_percentage"
        case effectiveTimeFrame = "effective_time_frame"
        case isMainSleep = "is_main_sleep"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "deep-sleep", version: "1.0")

    /// The duration of deep sleep
    public var deepSleepDuration: DurationUnitValue

    /// The total sleep time
    public var totalSleepTime: DurationUnitValue

    /// The percentage of the total sleep time spent in deep sleep
    public var deepSleepPercentage: PercentUnitValue?

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// Whether this measurement refers to the main sleep episode of the day
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        deepSleepDuration: DurationUnitValue,
        totalSleepTime: DurationUnitValue,
        effectiveTimeFrame: TimeFrame,
        deepSleepPercentage: PercentUnitValue? = nil,
        isMainSleep: Bool? = nil, // swiftlint:disable:this discouraged_optional_boolean
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.deepSleepDuration = deepSleepDuration
        self.totalSleepTime = totalSleepTime
        self.deepSleepPercentage = deepSleepPercentage
        self.effectiveTimeFrame = effectiveTimeFrame
        self.isMainSleep = isMainSleep
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        deepSleepDuration = try container.decode(DurationUnitValue.self, forKey: .deepSleepDuration)
        totalSleepTime = try container.decode(DurationUnitValue.self, forKey: .totalSleepTime)
        deepSleepPercentage = try container.decodeIfPresent(PercentUnitValue.self, forKey: .deepSleepPercentage)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        isMainSleep = try container.decodeIfPresent(Bool.self, forKey: .isMainSleep)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }
}
