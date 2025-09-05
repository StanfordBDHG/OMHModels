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


@Suite("Plane Angle Unit Value Tests")
struct PlaneAngleUnitValueTests {
    @Test("Plane Angle Unit Enum Cases")
    func testPlaneAngleUnitEnumCases() {
        #expect(PlaneAngleUnit.rad.rawValue == "rad")
        #expect(PlaneAngleUnit.deg.rawValue == "deg")
    }
    
    @Test("Plane Angle Unit Value with Degrees")
    func testPlaneAngleUnitValueWithDegrees() {
        let angleValue = PlaneAngleUnitValue(unit: .deg, value: 45.0)
        
        #expect(angleValue.unit == .deg)
        #expect(angleValue.value == 45.0)
    }
    
    @Test("Plane Angle Unit Value with Radians")
    func testPlaneAngleUnitValueWithRadians() {
        let angleValue = PlaneAngleUnitValue(unit: .rad, value: 3.14159)
        
        #expect(angleValue.unit == .rad)
        #expect(angleValue.value == 3.14159)
    }
    
    @Test("Plane Angle Unit Value with Integer")
    func testPlaneAngleUnitValueWithInteger() {
        let angleValue = PlaneAngleUnitValue(unit: .deg, value: 90)
        
        #expect(angleValue.unit == .deg)
        #expect(angleValue.value == 90.0)
    }
    
    @Test("Plane Angle Unit Value Encoding")
    func testPlaneAngleUnitValueEncoding() throws {
        let angleValue = PlaneAngleUnitValue(unit: .deg, value: 180.0)
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(angleValue)
        let jsonString = String(data: data, encoding: .utf8)
        
        #expect(jsonString?.contains("\"unit\":\"deg\"") == true)
        #expect(jsonString?.contains("\"value\":180") == true)
    }
    
    @Test("Plane Angle Unit Value Decoding Degrees")
    func testPlaneAngleUnitValueDecodingDegrees() throws {
        let json = """
        {
            "unit": "deg",
            "value": 270.5
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let angleValue = try decoder.decode(PlaneAngleUnitValue.self, from: data)
        
        #expect(angleValue.unit == .deg)
        #expect(angleValue.value == 270.5)
    }
    
    @Test("Plane Angle Unit Value Decoding Radians")
    func testPlaneAngleUnitValueDecodingRadians() throws {
        let json = """
        {
            "unit": "rad",
            "value": 1.5708
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let angleValue = try decoder.decode(PlaneAngleUnitValue.self, from: data)
        
        #expect(angleValue.unit == .rad)
        #expect(angleValue.value == 1.5708)
    }
    
    @Test("Plane Angle Unit Value Equality")
    func testPlaneAngleUnitValueEquality() {
        let angle1 = PlaneAngleUnitValue(unit: .deg, value: 45.0)
        let angle2 = PlaneAngleUnitValue(unit: .deg, value: 45.0)
        let angle3 = PlaneAngleUnitValue(unit: .rad, value: 45.0)
        let angle4 = PlaneAngleUnitValue(unit: .deg, value: 90.0)
        
        #expect(angle1 == angle2)
        #expect(angle1 != angle3)
        #expect(angle1 != angle4)
    }
    
    @Test("Invalid Plane Angle Unit Decoding")
    func testInvalidPlaneAngleUnitDecoding() throws {
        let json = """
        {
            "unit": "invalid_unit",
            "value": 45.0
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        #expect(throws: DecodingError.self) {
            _ = try decoder.decode(PlaneAngleUnitValue.self, from: data)
        }
    }
}
