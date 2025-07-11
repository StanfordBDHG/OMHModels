//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import Testing
import Foundation


@Suite("Typed Unit Value Tests")
struct TypedUnitValueTests {
    struct TestUnit: UnitProtocol, Equatable {
        var name: String
    }
    
    @Test("Typed Unit Value with Double Value")
    func testTypedUnitValueWithDoubleValue() {
        let unit = TestUnit(name: "TestUnit1")
        let value: Double = 10.5

        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        #expect(typedUnitValue.unit == unit)
        #expect(typedUnitValue.value == value)
    }

    @Test("Typed Unit Value with Int Value")
    func testTypedUnitValueWithIntValue() {
        let unit = TestUnit(name: "TestUnit2")
        let intValue: Int = 10
        let doubleValue = Double(intValue)

        let typedUnitValue = TypedUnitValue(unit: unit, value: intValue)

        #expect(typedUnitValue.unit == unit)
        #expect(typedUnitValue.value == doubleValue)
    }

    @Test("Typed Unit Value Decoding")
    func testTypedUnitValueDecoding() throws {
        let json = """
        {
            "unit": {
                "name": "TestUnit3"
            },
            "value": 15.5
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            Issue.record("Failed to convert JSON to data")
            return
        }
        
        let decoder = JSONDecoder()
        let typedUnitValue = try decoder.decode(TypedUnitValue<TestUnit>.self, from: data)

        #expect(typedUnitValue.unit.name == "TestUnit3")
        #expect(typedUnitValue.value == 15.5)
    }

    @Test("Typed Unit Value Encoding")
    func testTypedUnitValueEncoding() throws {
        let unit = TestUnit(name: "TestUnit4")
        let value: Double = 20.5
        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        let encoder = JSONEncoder()
        #expect(throws: Never.self) {
            try encoder.encode(typedUnitValue)
        }
    }

    @Test("Typed Unit Value Equality")
    func testTypedUnitValueEquality() {
        let unit1 = TestUnit(name: "TestUnit5")
        let unit2 = TestUnit(name: "TestUnit6")

        let value1 = TypedUnitValue(unit: unit1, value: 30.0)
        let value2 = TypedUnitValue(unit: unit1, value: 30.0)
        let value3 = TypedUnitValue(unit: unit2, value: 40.0)

        #expect(value1 == value2)
        #expect(value1 != value3)
    }
}
