//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// Total amount of time spent asleep
/// Generated from IEEE 1752.1 `total-sleep-time-1.0` (https://w3id.org/ieee/ieee-1752-schema/total-sleep-time.json)
public struct TotalSleepTime: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "total-sleep-time", version: "1.0")
    
    /// The total amount of time spent asleep
    public var totalSleepTime: DurationUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame
    
    // We disable this rule to stay conformant to the schema
    public var isMainSleep: Bool? // swiftlint:disable:this discouraged_optional_boolean
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    /// The denominator of the descriptive statistic when the measures has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?
    
    
    public init(
        totalSleepTime: DurationUnitValue,
        effectiveTimeFrame: TimeFrame,
        isMainSleep: Bool? = nil, // swiftlint:disable:this discouraged_optional_boolean
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.totalSleepTime = totalSleepTime
        self.effectiveTimeFrame = effectiveTimeFrame
        self.isMainSleep = isMainSleep
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }
}
