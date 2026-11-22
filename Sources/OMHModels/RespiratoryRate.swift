//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Respiratory Rate measurement
/// Generated from Open mHealth `omh:respiratory-rate:3.0` (https://w3id.org/openmhealth/schemas/omh/respiratory-rate-3.0.json)
public struct RespiratoryRate: Schema, Equatable {
    private enum CodingKeys: String, CodingKey {
        case respiratoryRate = "respiratory_rate"
        case effectiveTimeFrame = "effective_time_frame"
        case temporalRelationshipToPhysicalActivity = "temporal_relationship_to_physical_activity"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "respiratory-rate", version: "3.0")
    
    /// The heart rate measurement as a `UnitValue` containing a double value and unit
    public var respiratoryRate: RespiratoryRateUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame
    
    /// The relationship of this measurement to physical activity
    public var temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity?
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init(
        respiratoryRate: RespiratoryRateUnitValue,
        effectiveTimeFrame: TimeFrame,
        temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.respiratoryRate = respiratoryRate
        self.effectiveTimeFrame = effectiveTimeFrame
        self.temporalRelationshipToPhysicalActivity = temporalRelationshipToPhysicalActivity
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        respiratoryRate = try container.decode(RespiratoryRateUnitValue.self, forKey: .respiratoryRate)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        temporalRelationshipToPhysicalActivity = try container.decodeIfPresent(
            TemporalRelationshipToPhysicalActivity.self,
            forKey: .temporalRelationshipToPhysicalActivity
        )
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
