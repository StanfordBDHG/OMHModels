//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Body Height measurement
/// Generated from Open mHealth `omh:body-height:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-height)
public struct BodyHeight: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-height", version: "1.0")

    /// The body weight measurement as a `UnitValue` containing a double value and unit
    public var bodyHeight: LengthUnitValue

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?


    public init(
        bodyHeight: LengthUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bodyHeight = bodyHeight
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }
}
