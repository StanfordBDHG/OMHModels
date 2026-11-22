//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Body Temperature measurement
/// Generated from Open mHealth `omh:body-temperature:3.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-temperature)
public struct BodyTemperature: Schema, Equatable {
    private enum CodingKeys: String, CodingKey {
        case bodyTemperature = "body_temperature"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-temperature", version: "3.0")
    
    /// The body temperature measurement as a `UnitValue` containing a double value and a unit
    public var bodyTemperature: TemperatureUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init(
        bodyTemperature: TemperatureUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bodyTemperature = bodyTemperature
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        bodyTemperature = try container.decode(TemperatureUnitValue.self, forKey: .bodyTemperature)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
