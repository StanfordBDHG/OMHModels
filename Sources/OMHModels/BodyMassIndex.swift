//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Body Mass Index (BMI) calculation in kg/m^2
/// Generated from Open mHealth `omh:body-mass-index:2.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-mass-index)
public struct BodyMassIndex: Schema, Equatable {
    private enum CodingKeys: String, CodingKey {
        case bodyMassIndex = "body_mass_index"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-mass-index", version: "2.0")
    
    /// The body mass index
    public var bodyMassIndex: BodyMassIndexUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?


    public init (
        bodyMassIndex: BodyMassIndexUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bodyMassIndex = bodyMassIndex
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        bodyMassIndex = try container.decode(BodyMassIndexUnitValue.self, forKey: .bodyMassIndex)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
