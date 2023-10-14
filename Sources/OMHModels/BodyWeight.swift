//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Body Weight measurement
/// Generated from Open mHealth `omh:body-weight:2.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-weight)
public struct BodyWeight: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-weight", version: "2.0")

    /// The body weight measurement as a `UnitValue` containing a double value and unit
    public var bodyWeight: MassUnitValue

    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?


    public init(
        bodyWeight: MassUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bodyWeight = bodyWeight
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }
}
