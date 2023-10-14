//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class TypedUnitValueRangeTests: XCTestCase {
    // Dummy unit for testing
    struct TestUnit: UnitProtocol, Equatable {
        var name: String
    }
    
    func testInitialization() {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit1"), lowValue: 10.0, highValue: 20.0)
        XCTAssertEqual(range.unit, TestUnit(name: "TestUnit1"))
        XCTAssertEqual(range.lowValue, 10.0)
        XCTAssertEqual(range.highValue, 20.0)
    }
    
    func testInitializationWithIntegers() {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit2"), lowValue: 10, highValue: 20)
        XCTAssertEqual(range.unit, TestUnit(name: "TestUnit2"))
        XCTAssertEqual(range.lowValue, 10.0)
        XCTAssertEqual(range.highValue, 20.0)
    }
    
    func testEquatable() {
        let range1 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 10, highValue: 20)
        let range2 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 10, highValue: 20)
        let range3 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 15, highValue: 25)
        
        XCTAssertEqual(range1, range2)
        XCTAssertNotEqual(range1, range3)
    }
    
    func testEncodingAndDecoding() throws {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit4"), lowValue: 10, highValue: 20)
        let encodedData = try JSONEncoder().encode(range)
        let decodedRange = try JSONDecoder().decode(TypedUnitValueRange<TestUnit>.self, from: encodedData)
        
        XCTAssertEqual(range, decodedRange)
    }
}
