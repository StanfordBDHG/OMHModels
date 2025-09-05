//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels
import Testing


@Suite("Geoposition Measurement Tests")
struct GeopositionMeasurementTests {
    
    var sampleDateTime: DateTime {
        DateTime(date: Date())
    }
    
    var sampleTimeFrame: TimeFrame {
        TimeFrame(dateTime: sampleDateTime)
    }
    
    var sampleLatitude: PlaneAngleUnitValue {
        PlaneAngleUnitValue(unit: .deg, value: 37.4419)  // Stanford University latitude
    }
    
    var sampleLongitude: PlaneAngleUnitValue {
        PlaneAngleUnitValue(unit: .deg, value: -122.1430)  // Stanford University longitude
    }
    
    @Test("Positioning System Enum Cases")
    func testPositioningSystemEnumCases() {
        #expect(PositioningSystem.GPS.rawValue == "GPS")
        #expect(PositioningSystem.GLONASS.rawValue == "GLONASS")
        #expect(PositioningSystem.Galileo.rawValue == "Galileo")
        #expect(PositioningSystem.Beidou.rawValue == "Beidou")
        #expect(PositioningSystem.COMPASS.rawValue == "COMPASS")
        #expect(PositioningSystem.IRNSS.rawValue == "IRNSS")
        #expect(PositioningSystem.QZSS.rawValue == "QZSS")
    }
    
    @Test("Satellite Signal Strength Creation")
    func testSatelliteSignalStrengthCreation() {
        let signalStrength = SatelliteSignalStrength(value: 25)
        
        #expect(signalStrength.unit == "dB")
        #expect(signalStrength.value == 25)
    }
    
    @Test("Satellite Signal Strength Encoding")
    func testSatelliteSignalStrengthEncoding() throws {
        let signalStrength = SatelliteSignalStrength(value: 30)
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(signalStrength)
        let jsonString = String(data: data, encoding: .utf8)
        
        #expect(jsonString?.contains("\"unit\":\"dB\"") == true)
        #expect(jsonString?.contains("\"value\":30") == true)
    }
    
    @Test("Satellite Signal Strength Decoding")
    func testSatelliteSignalStrengthDecoding() throws {
        let json = """
        {
            "unit": "dB",
            "value": 35
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let signalStrength = try decoder.decode(SatelliteSignalStrength.self, from: data)
        
        #expect(signalStrength.unit == "dB")
        #expect(signalStrength.value == 35)
    }
    
    @Test("Satellite Signal Strength Invalid Unit Decoding")
    func testSatelliteSignalStrengthInvalidUnitDecoding() throws {
        let json = """
        {
            "unit": "invalid",
            "value": 35
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        #expect(throws: DecodingError.self) {
            _ = try decoder.decode(SatelliteSignalStrength.self, from: data)
        }
    }
    
    @Test("Elevation Measurement with Meters")
    func testElevationMeasurementWithMeters() {
        let elevation = ElevationMeasurement(unit: .m, value: 100.5)
        
        #expect(elevation.unit == .m)
        #expect(elevation.value == 100.5)
    }
    
    @Test("Elevation Measurement with Feet")
    func testElevationMeasurementWithFeet() {
        let elevation = ElevationMeasurement(unit: .ft, value: 330.0)
        
        #expect(elevation.unit == .ft)
        #expect(elevation.value == 330.0)
    }
    
    @Test("Elevation Measurement Encoding")
    func testElevationMeasurementEncoding() throws {
        let elevation = ElevationMeasurement(unit: .m, value: 50.25)
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(elevation)
        let jsonString = String(data: data, encoding: .utf8)
        
        #expect(jsonString?.contains("\"unit\":\"m\"") == true)
        #expect(jsonString?.contains("\"value\":50.25") == true)
    }
    
    @Test("Elevation Measurement Decoding")
    func testElevationMeasurementDecoding() throws {
        let json = """
        {
            "unit": "ft",
            "value": 1000.0
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let elevation = try decoder.decode(ElevationMeasurement.self, from: data)
        
        #expect(elevation.unit == .ft)
        #expect(elevation.value == 1000.0)
    }
    
    @Test("Basic Geoposition Measurement Creation")
    func testBasicGeopositionMeasurementCreation() {
        let geoposition = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            effectiveTimeFrame: sampleTimeFrame
        )
        
        #expect(geoposition.latitude == sampleLatitude)
        #expect(geoposition.longitude == sampleLongitude)
        #expect(geoposition.effectiveTimeFrame == sampleTimeFrame)
        #expect(geoposition.elevation == nil)
        #expect(geoposition.numberOfSatellitesInView == nil)
        #expect(geoposition.satelliteSignalStrengths == nil)
        #expect(geoposition.numberOfSatellitesInFix == nil)
        #expect(geoposition.positioningSystem == nil)
    }
    
    @Test("Complete Geoposition Measurement Creation")
    func testCompleteGeopositionMeasurementCreation() {
        let elevation = ElevationMeasurement(unit: .m, value: 15.0)
        let signalStrengths = [
            SatelliteSignalStrength(value: 25),
            SatelliteSignalStrength(value: 30),
            SatelliteSignalStrength(value: 22)
        ]
        
        let geoposition = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            elevation: elevation,
            effectiveTimeFrame: sampleTimeFrame,
            numberOfSatellitesInView: 8,
            satelliteSignalStrengths: signalStrengths,
            numberOfSatellitesInFix: 6,
            positioningSystem: .GPS
        )
        
        #expect(geoposition.latitude == sampleLatitude)
        #expect(geoposition.longitude == sampleLongitude)
        #expect(geoposition.elevation == elevation)
        #expect(geoposition.effectiveTimeFrame == sampleTimeFrame)
        #expect(geoposition.numberOfSatellitesInView == 8)
        #expect(geoposition.satelliteSignalStrengths == signalStrengths)
        #expect(geoposition.numberOfSatellitesInFix == 6)
        #expect(geoposition.positioningSystem == .GPS)
    }
    
    @Test("Geoposition Measurement Encoding")
    func testGeopositionMeasurementEncoding() throws {
        let elevation = ElevationMeasurement(unit: .ft, value: 50.0)
        let geoposition = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            elevation: elevation,
            effectiveTimeFrame: sampleTimeFrame,
            numberOfSatellitesInView: 10,
            numberOfSatellitesInFix: 8,
            positioningSystem: .Galileo
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(geoposition)
        let jsonString = String(data: data, encoding: .utf8)
        
        #expect(jsonString?.contains("\"latitude\"") == true)
        #expect(jsonString?.contains("\"longitude\"") == true)
        #expect(jsonString?.contains("\"elevation\"") == true)
        #expect(jsonString?.contains("\"effective_time_frame\"") == true)
        #expect(jsonString?.contains("\"number_of_satellites_in_view\"") == true)
        #expect(jsonString?.contains("\"number_of_satellites_in_fix\"") == true)
        #expect(jsonString?.contains("\"positioning_system\"") == true)
        #expect(jsonString?.contains("\"Galileo\"") == true)
    }
    
    @Test("Geoposition Measurement Basic Decoding")
    func testGeopositionMeasurementBasicDecoding() throws {
        let json = """
        {
            "latitude": {
                "unit": "deg",
                "value": 37.4419
            },
            "longitude": {
                "unit": "deg",
                "value": -122.1430
            },
            "effective_time_frame": {
                "date_time": "2023-12-25T10:30:00Z"
            }
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let geoposition = try decoder.decode(GeopositionMeasurement.self, from: data)
        
        #expect(geoposition.latitude.unit == .deg)
        #expect(geoposition.latitude.value == 37.4419)
        #expect(geoposition.longitude.unit == .deg)
        #expect(geoposition.longitude.value == -122.1430)
        #expect(geoposition.effectiveTimeFrame.dateTime != nil)
        #expect(geoposition.elevation == nil)
    }
    
    @Test("Geoposition Measurement Complete Decoding")
    func testGeopositionMeasurementCompleteDecoding() throws {
        let json = """
        {
            "latitude": {
                "unit": "deg",
                "value": 40.7128
            },
            "longitude": {
                "unit": "deg",
                "value": -74.0060
            },
            "elevation": {
                "unit": "m",
                "value": 10.0
            },
            "effective_time_frame": {
                "date_time": "2023-12-25T15:45:30Z"
            },
            "number_of_satellites_in_view": 12,
            "satellite_signal_strengths": [
                {
                    "unit": "dB",
                    "value": 25
                },
                {
                    "unit": "dB",
                    "value": 30
                }
            ],
            "number_of_satellites_in_fix": 8,
            "positioning_system": "GPS"
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let geoposition = try decoder.decode(GeopositionMeasurement.self, from: data)
        
        #expect(geoposition.latitude.value == 40.7128)
        #expect(geoposition.longitude.value == -74.0060)
        #expect(geoposition.elevation?.unit == .m)
        #expect(geoposition.elevation?.value == 10.0)
        #expect(geoposition.numberOfSatellitesInView == 12)
        #expect(geoposition.satelliteSignalStrengths?.count == 2)
        #expect(geoposition.satelliteSignalStrengths?[0].value == 25)
        #expect(geoposition.satelliteSignalStrengths?[1].value == 30)
        #expect(geoposition.numberOfSatellitesInFix == 8)
        #expect(geoposition.positioningSystem == .GPS)
    }
    
    @Test("Geoposition Measurement Invalid Time Frame Decoding")
    func testGeopositionMeasurementInvalidTimeFrameDecoding() throws {
        let json = """
        {
            "latitude": {
                "unit": "deg",
                "value": 37.4419
            },
            "longitude": {
                "unit": "deg",
                "value": -122.1430
            },
            "effective_time_frame": {
                "time_interval": {
                    "duration": {
                        "value": 1,
                        "unit": "h"
                    },
                    "end_date_time": "2023-12-25T11:30:00Z"
                }
            }
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        #expect(throws: DecodingError.self) {
            _ = try decoder.decode(GeopositionMeasurement.self, from: data)
        }
    }
    
    @Test("Geoposition Measurement Equality")
    func testGeopositionMeasurementEquality() {
        let elevation1 = ElevationMeasurement(unit: .m, value: 100.0)
        let elevation2 = ElevationMeasurement(unit: .m, value: 100.0)
        let elevation3 = ElevationMeasurement(unit: .ft, value: 100.0)
        
        let geoposition1 = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            elevation: elevation1,
            effectiveTimeFrame: sampleTimeFrame,
            positioningSystem: .GPS
        )
        
        let geoposition2 = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            elevation: elevation2,
            effectiveTimeFrame: sampleTimeFrame,
            positioningSystem: .GPS
        )
        
        let geoposition3 = GeopositionMeasurement(
            latitude: sampleLatitude,
            longitude: sampleLongitude,
            elevation: elevation3,
            effectiveTimeFrame: sampleTimeFrame,
            positioningSystem: .GPS
        )
        
        #expect(geoposition1 == geoposition2)
        #expect(geoposition1 != geoposition3)
    }
    
    @Test("Schema ID")
    func testSchemaId() {
        #expect(GeopositionMeasurement.schemaId.namespace == .omh)
        #expect(GeopositionMeasurement.schemaId.name == "geoposition-measurement")
        #expect(GeopositionMeasurement.schemaId.version == "1.0")
    }
}