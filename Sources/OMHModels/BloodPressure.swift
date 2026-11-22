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
    private enum CodingKeys: String, CodingKey {
        case systolicBloodPressure = "systolic_blood_pressure"
        case diastolicBloodPressure = "diastolic_blood_pressure"
        case bodyPosture = "body_posture"
        case bodyLocation = "body_location"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
        case temporalRelationshipToPhysicalActivity = "temporal_relationship_to_physical_activity"
    }

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


    public init(
        systolicBloodPressure: BloodPressureUnitValue,
        diastolicBloodPressure: BloodPressureUnitValue,
        effectiveTimeFrame: TimeFrame,
        bodyPosture: BodyPosture? = nil,
        bodyLocation: BodyLocation? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity? = nil
    ) {
        self.systolicBloodPressure = systolicBloodPressure
        self.diastolicBloodPressure = diastolicBloodPressure
        self.effectiveTimeFrame = effectiveTimeFrame
        self.bodyPosture = bodyPosture
        self.bodyLocation = bodyLocation
        self.descriptiveStatistic = descriptiveStatistic
        self.temporalRelationshipToPhysicalActivity = temporalRelationshipToPhysicalActivity
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        systolicBloodPressure = try container.decode(BloodPressureUnitValue.self, forKey: .systolicBloodPressure)
        diastolicBloodPressure = try container.decode(BloodPressureUnitValue.self, forKey: .diastolicBloodPressure)
        bodyPosture = try container.decodeIfPresent(BodyPosture.self, forKey: .bodyPosture)
        bodyLocation = try container.decodeIfPresent(BodyLocation.self, forKey: .bodyLocation)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        temporalRelationshipToPhysicalActivity = try container.decodeIfPresent(
            TemporalRelationshipToPhysicalActivity.self,
            forKey: .temporalRelationshipToPhysicalActivity
        )
    }
}
