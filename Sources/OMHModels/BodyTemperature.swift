//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The location on the body where a body temperature measurement was taken
public enum BodyTemperatureMeasurementLocation: String, Codable, Hashable, Sendable {
    case axillary
    case finger
    case forehead
    case oral
    case rectal
    case temporalArtery = "temporal artery"
    case toe
    case tympanic
    case wrist
    case vagina
}

/// A Body Temperature measurement
/// Generated from Open mHealth `omh:body-temperature:4.0` (https://w3id.org/openmhealth/schemas/omh/body-temperature-4.0.json)
public struct BodyTemperature: Schema, Equatable {
    private enum CodingKeys: String, CodingKey {
        case bodyTemperature = "body_temperature"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
        case measurementLocation = "measurement_location"
        case temporalRelationshipToSleep = "temporal_relationship_to_sleep"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-temperature", version: "4.0")
    
    /// The body temperature measurement as a `UnitValue` containing a double value and a unit
    public var bodyTemperature: TemperatureUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?

    /// The location on the body where the measurement was taken
    public var measurementLocation: BodyTemperatureMeasurementLocation?

    /// The relationship of this measurement to sleep (e.g. on waking)
    public var temporalRelationshipToSleep: TemporalRelationshipToSleep?
    
    
    public init(
        bodyTemperature: TemperatureUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        measurementLocation: BodyTemperatureMeasurementLocation? = nil,
        temporalRelationshipToSleep: TemporalRelationshipToSleep? = nil
    ) {
        self.bodyTemperature = bodyTemperature
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
        self.measurementLocation = measurementLocation
        self.temporalRelationshipToSleep = temporalRelationshipToSleep
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        bodyTemperature = try container.decode(TemperatureUnitValue.self, forKey: .bodyTemperature)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
        measurementLocation = try container.decodeIfPresent(BodyTemperatureMeasurementLocation.self, forKey: .measurementLocation)
        temporalRelationshipToSleep = try container.decodeIfPresent(TemporalRelationshipToSleep.self, forKey: .temporalRelationshipToSleep)
    }
}
