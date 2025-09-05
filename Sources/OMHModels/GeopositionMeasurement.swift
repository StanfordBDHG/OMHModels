//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation

/// Known positioning systems
public enum PositioningSystem: String, Codable, CaseIterable, Sendable {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case GPS
    case GLONASS
    case Galileo
    case Beidou
    case COMPASS
    case IRNSS
    case QZSS
    // swiftlint:enable identifier_name
}

/// Signal-to-noise ratio measurement in decibels
public struct SatelliteSignalStrength: Codable, Equatable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case unit, value
    }
    
    public let unit: String = "dB"
    public let value: Int
    
    public init(value: Int) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodedUnit = try container.decode(String.self, forKey: .unit)
        guard decodedUnit == "dB" else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "Invalid unit for satellite signal strength")
            )
        }
        value = try container.decode(Int.self, forKey: .value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unit, forKey: .unit)
        try container.encode(value, forKey: .value)
    }
}

/// Elevation measurement with restricted units (meters or feet)
public struct ElevationMeasurement: Codable, Equatable, Sendable {
    public enum ElevationUnit: String, Codable, Sendable {
        // swiftlint:disable identifier_name
        // We disable this rule because we must use case names as defined by Open mHealth.
        case m
        case ft
        // swiftlint:enable identifier_name
    }
    
    private enum CodingKeys: String, CodingKey {
        case unit, value
    }
    
    public let unit: ElevationUnit
    public let value: Double
    
    public init(unit: ElevationUnit, value: Double) {
        self.unit = unit
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        unit = try container.decode(ElevationUnit.self, forKey: .unit)
        value = try container.decode(Double.self, forKey: .value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unit, forKey: .unit)
        try container.encode(value, forKey: .value)
    }
}

/// A geographic position measurement
/// This schema represents a geographic position measurement.
public struct GeopositionMeasurement: Schema, Codable, Equatable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case elevation
        case effectiveTimeFrame = "effective_time_frame"
        case numberOfSatellitesInView = "number_of_satellites_in_view"
        case satelliteSignalStrengths = "satellite_signal_strengths"
        case numberOfSatellitesInFix = "number_of_satellites_in_fix"
        case positioningSystem = "positioning_system"
    }
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "geoposition-measurement", version: "1.0")
    
    /// The angular distance of a place north or south of the earth's equator expressed in degrees
    public let latitude: PlaneAngleUnitValue
    
    /// The angular distance of a place east or west of the meridian at Greenwich, England, expressed in degrees
    public let longitude: PlaneAngleUnitValue
    
    /// The height above or below a fixed reference point, most commonly a reference geoid
    public let elevation: ElevationMeasurement?
    
    /// A geoposition should be associated to a date time time frame
    public let effectiveTimeFrame: TimeFrame
    
    /// The number of satellites that can potentially be used to determine position
    public let numberOfSatellitesInView: Int?
    
    /// Signal-to-noise ratios (SNR) expressed in decibels (dB)
    public let satelliteSignalStrengths: [SatelliteSignalStrength]
    
    /// The number of satellites actually used to determine position
    public let numberOfSatellitesInFix: Int?
    
    /// Known systems are listed. Others can be added, if needed. More than one can be used at the same time
    public let positioningSystem: PositioningSystem?
    
    public init(
        latitude: PlaneAngleUnitValue,
        longitude: PlaneAngleUnitValue,
        effectiveTimeFrame: TimeFrame,
        elevation: ElevationMeasurement? = nil,
        numberOfSatellitesInView: Int? = nil,
        numberOfSatellitesInFix: Int? = nil,
        positioningSystem: PositioningSystem? = nil,
        satelliteSignalStrengths: [SatelliteSignalStrength] = []
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.elevation = elevation
        self.effectiveTimeFrame = effectiveTimeFrame
        self.numberOfSatellitesInView = numberOfSatellitesInView
        self.satelliteSignalStrengths = satelliteSignalStrengths
        self.numberOfSatellitesInFix = numberOfSatellitesInFix
        self.positioningSystem = positioningSystem
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        latitude = try container.decode(PlaneAngleUnitValue.self, forKey: .latitude)
        longitude = try container.decode(PlaneAngleUnitValue.self, forKey: .longitude)
        elevation = try container.decodeIfPresent(ElevationMeasurement.self, forKey: .elevation)
        
        let timeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        guard timeFrame.dateTime != nil else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "effective_time_frame must have date_time")
            )
        }
        effectiveTimeFrame = timeFrame
        
        numberOfSatellitesInView = try container.decodeIfPresent(Int.self, forKey: .numberOfSatellitesInView)
        satelliteSignalStrengths = try container.decodeIfPresent([SatelliteSignalStrength].self, forKey: .satelliteSignalStrengths) ?? []
        numberOfSatellitesInFix = try container.decodeIfPresent(Int.self, forKey: .numberOfSatellitesInFix)
        positioningSystem = try container.decodeIfPresent(PositioningSystem.self, forKey: .positioningSystem)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encodeIfPresent(elevation, forKey: .elevation)
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(numberOfSatellitesInView, forKey: .numberOfSatellitesInView)
        if !satelliteSignalStrengths.isEmpty {
            try container.encode(satelliteSignalStrengths, forKey: .satelliteSignalStrengths)
        }
        try container.encodeIfPresent(numberOfSatellitesInFix, forKey: .numberOfSatellitesInFix)
        try container.encodeIfPresent(positioningSystem, forKey: .positioningSystem)
    }
}
