//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Units for the number of apnea and hypopnea events per hour of sleep
public enum ApneaHypopneaIndexUnit: String, UnitProtocol, Hashable {
    case eventsPerHour = "events/h"
}

/// A type representing the number of apnea and hypopnea events per hour of sleep
public typealias ApneaHypopneaIndexUnitValue = TypedUnitValue<ApneaHypopneaIndexUnit>

/// Number of apnea and hypopnea events per hour of sleep
/// Generated from IEEE 1752.1 `apnea-hypopnea-index-1.0` (https://w3id.org/ieee/ieee-1752-schema/apnea-hypopnea-index.json)
public struct ApneaHypopneaIndex: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case apneaHypopneaIndex = "apnea_hypopnea_index"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
        case descriptiveStatisticDenominator = "descriptive_statistic_denominator"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "apnea-hypopnea-index", version: "1.0")

    /// The number of apnea and hypopnea events per hour of sleep
    public var apneaHypopneaIndex: ApneaHypopneaIndexUnitValue

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The denominator of the descriptive statistic when the measure has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?


    public init(
        apneaHypopneaIndex: ApneaHypopneaIndexUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.apneaHypopneaIndex = apneaHypopneaIndex
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        apneaHypopneaIndex = try container.decode(ApneaHypopneaIndexUnitValue.self, forKey: .apneaHypopneaIndex)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        descriptiveStatisticDenominator = try container.decodeIfPresent(
            DescriptiveStatisticDenominator.self,
            forKey: .descriptiveStatisticDenominator
        )
    }
}
