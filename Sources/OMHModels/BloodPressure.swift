//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation

/// A Blood Pressure measurement
/// Generated from Open mHealth `omh:blood-pressure:3.1` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_blood-pressure)
public struct BloodPressure: Schema, Codable, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "blood-pressure", version: "3.1")

    /// The systolic blood pressure measurement in mmHg
    public var systolicBloodPressure: BloodPressureUnitValue

    /// The diastolic blood pressure measurement in mmHg
    public var diastolicBloodPressure: BloodPressureUnitValue

    /// The posture in which the measurement was taken
    public var bodyPosture: BodyPosture?

    /// The location on the body in which the measurement was taken
    public var bodyLocation: BodyLocation?

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The relationship of this measurement to physical activity
    public var temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity?
}
