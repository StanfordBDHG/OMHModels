//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


// swiftlint:disable identifier_name
// We disable this rule because we must use the unit names defined by IEEE 1752
/// Units for the wavelength of ambient light
public enum WavelengthUnit: String, UnitProtocol, Hashable {
    case nm
}
// swiftlint:enable identifier_name

/// A type representing the wavelength of ambient light
public typealias WavelengthUnitValue = TypedUnitValue<WavelengthUnit>

/// The intensity of ambient light, optionally at a specific wavelength
public struct AmbientLightMeasurement: Codable, Hashable, Sendable {
    /// The wavelength of the light
    public var wavelength: WavelengthUnitValue?

    /// The intensity of the light
    public var intensity: IlluminanceUnitValue


    public init(
        intensity: IlluminanceUnitValue,
        wavelength: WavelengthUnitValue? = nil
    ) {
        self.wavelength = wavelength
        self.intensity = intensity
    }
}

/// The light in the environment surrounding a person
/// Generated from IEEE 1752.1 `ambient-light-1.0` (https://w3id.org/ieee/ieee-1752-schema/ambient-light.json)
public struct AmbientLight: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case ambientLight = "ambient_light"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "ambient-light", version: "1.0")

    /// The intensity of the ambient light, optionally per wavelength
    public var ambientLight: [AmbientLightMeasurement]

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?


    public init(
        ambientLight: [AmbientLightMeasurement],
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.ambientLight = ambientLight
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        ambientLight = try container.decode([AmbientLightMeasurement].self, forKey: .ambientLight)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
