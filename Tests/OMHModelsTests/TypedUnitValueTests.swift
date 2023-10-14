//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class TypedUnitValueTests: XCTestCase {
    struct TestUnit: UnitProtocol, Equatable {
        var name: String
    }
    
    func testTypedUnitValueWithDoubleValue() {
        let unit = TestUnit(name: "TestUnit1")
        let value: Double = 10.5

        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        XCTAssertEqual(typedUnitValue.unit, unit)
        XCTAssertEqual(typedUnitValue.value, value)
    }

    func testTypedUnitValueWithIntValue() {
        let unit = TestUnit(name: "TestUnit2")
        let intValue: Int = 10
        let doubleValue = Double(intValue)

        let typedUnitValue = TypedUnitValue(unit: unit, value: intValue)

        XCTAssertEqual(typedUnitValue.unit, unit)
        XCTAssertEqual(typedUnitValue.value, doubleValue)
    }

    func testTypedUnitValueDecoding() throws {
        let json = """
        {
            "unit": {
                "name": "TestUnit3"
            },
            "value": 15.5
        }
        """
        
        let data = try XCTUnwrap(json.data(using: .utf8))
        
        let decoder = JSONDecoder()
        let typedUnitValue = try decoder.decode(TypedUnitValue<TestUnit>.self, from: data)

        XCTAssertEqual(typedUnitValue.unit.name, "TestUnit3")
        XCTAssertEqual(typedUnitValue.value, 15.5)
    }

    func testTypedUnitValueEncoding() throws {
        let unit = TestUnit(name: "TestUnit4")
        let value: Double = 20.5
        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        let encoder = JSONEncoder()
        XCTAssertNoThrow(try encoder.encode(typedUnitValue), "Encoding should not throw an error")
    }

    func testTypedUnitValueEquality() {
        let unit1 = TestUnit(name: "TestUnit5")
        let unit2 = TestUnit(name: "TestUnit6")

        let value1 = TypedUnitValue(unit: unit1, value: 30.0)
        let value2 = TypedUnitValue(unit: unit1, value: 30.0)
        let value3 = TypedUnitValue(unit: unit2, value: 40.0)

        XCTAssertEqual(value1, value2)
        XCTAssertNotEqual(value1, value3)
    }
}
