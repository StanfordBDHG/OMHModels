//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Step Count measurement
/// Generated from Open mHealth `omh:step-count:3.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_step-count)
public struct StepCount: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "step-count", version: "3.0")
    
    /// The step count measurement as a `UnitValue` containing a double value and a unit
    public var stepCount: StepCountUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    /// The denominator of the descriptive statistic when the measures has an implicit duration. For example in the context of step count, if the descriptive statistic is 'average' and the statistic denominator is 'd' the value describes average daily step count during the period delimited by the effective time frame; in the context of step count, if the descriptive statistic is 'maximum' and the statistic denominator is 'session' the value describes maximum step count per session during the period delimited by the effective time frame.
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?
    
    
    public init (
        stepCount: StepCountUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.stepCount = stepCount
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }
}
