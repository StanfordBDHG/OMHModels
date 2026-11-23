//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation

/// A Blood Pressure measurement
/// Generated from Open mHealth `omh:blood-pressure:4.0` (https://w3id.org/openmhealth/schemas/omh/blood-pressure-4.0.json)
public struct BloodPressure: Schema, Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case systolicBloodPressure = "systolic_blood_pressure"
        case diastolicBloodPressure = "diastolic_blood_pressure"
        case bodyPosture = "body_posture"
        case measurementLocation = "measurement_location"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
        case temporalRelationshipToPhysicalActivity = "temporal_relationship_to_physical_activity"
        /// Versions of `blood-pressure` before 4.0 named the measurement location `body_location`.
        case bodyLocation = "body_location"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "blood-pressure", version: "4.0")

    /// The systolic blood pressure measurement in mmHg
    public var systolicBloodPressure: BloodPressureUnitValue

    /// The diastolic blood pressure measurement in mmHg
    public var diastolicBloodPressure: BloodPressureUnitValue

    /// The posture in which the measurement was taken
    public var bodyPosture: BodyPosture?

    /// The location on the body in which the measurement was taken
    public var measurementLocation: BodyLocation?

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The relationship of this measurement to physical activity
    public var temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity?

    /// The location on the body in which the measurement was taken
    @available(*, deprecated, renamed: "measurementLocation") public var bodyLocation: BodyLocation? {
        get { measurementLocation }
        set { measurementLocation = newValue }
    }


    public init(
        systolicBloodPressure: BloodPressureUnitValue,
        diastolicBloodPressure: BloodPressureUnitValue,
        effectiveTimeFrame: TimeFrame,
        bodyPosture: BodyPosture? = nil,
        measurementLocation: BodyLocation? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity? = nil
    ) {
        self.systolicBloodPressure = systolicBloodPressure
        self.diastolicBloodPressure = diastolicBloodPressure
        self.effectiveTimeFrame = effectiveTimeFrame
        self.bodyPosture = bodyPosture
        self.measurementLocation = measurementLocation
        self.descriptiveStatistic = descriptiveStatistic
        self.temporalRelationshipToPhysicalActivity = temporalRelationshipToPhysicalActivity
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        systolicBloodPressure = try container.decode(BloodPressureUnitValue.self, forKey: .systolicBloodPressure)
        diastolicBloodPressure = try container.decode(BloodPressureUnitValue.self, forKey: .diastolicBloodPressure)
        bodyPosture = try container.decodeIfPresent(BodyPosture.self, forKey: .bodyPosture)
        measurementLocation = try container.decodeIfPresent(BodyLocation.self, forKey: .measurementLocation)
            ?? container.decodeIfPresent(BodyLocation.self, forKey: .bodyLocation)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        temporalRelationshipToPhysicalActivity = try container.decodeIfPresent(
            TemporalRelationshipToPhysicalActivity.self,
            forKey: .temporalRelationshipToPhysicalActivity
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(systolicBloodPressure, forKey: .systolicBloodPressure)
        try container.encode(diastolicBloodPressure, forKey: .diastolicBloodPressure)
        try container.encodeIfPresent(bodyPosture, forKey: .bodyPosture)
        try container.encodeIfPresent(measurementLocation, forKey: .measurementLocation)
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(descriptiveStatistic, forKey: .descriptiveStatistic)
        try container.encodeIfPresent(temporalRelationshipToPhysicalActivity, forKey: .temporalRelationshipToPhysicalActivity)
    }
}
