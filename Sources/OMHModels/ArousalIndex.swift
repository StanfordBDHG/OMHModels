//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Units for the number of awakenings per hour of sleep
public enum ArousalIndexUnit: String, UnitProtocol, Hashable {
    case awakeningsPerHour = "awakenings/h"
}

/// A type representing the number of awakenings per hour of sleep
public typealias ArousalIndexUnitValue = TypedUnitValue<ArousalIndexUnit>

/// Number of awakenings per hour of sleep
/// Generated from IEEE 1752.1 `arousal-index-1.0` (https://w3id.org/ieee/ieee-1752-schema/arousal-index.json)
public struct ArousalIndex: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case arousalIndex = "arousal_index"
        case effectiveTimeFrame = "effective_time_frame"
        case isMainSleep = "is_main_sleep"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "arousal-index", version: "1.0")

    /// The number of awakenings per hour of sleep
    public var arousalIndex: ArousalIndexUnitValue

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// Whether this measurement refers to the main sleep episode of the day
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        arousalIndex: ArousalIndexUnitValue,
        effectiveTimeFrame: TimeFrame,
        isMainSleep: Bool? = nil, // swiftlint:disable:this discouraged_optional_boolean
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.arousalIndex = arousalIndex
        self.effectiveTimeFrame = effectiveTimeFrame
        self.isMainSleep = isMainSleep
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        arousalIndex = try container.decode(ArousalIndexUnitValue.self, forKey: .arousalIndex)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        isMainSleep = try container.decodeIfPresent(Bool.self, forKey: .isMainSleep)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }
}
