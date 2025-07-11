//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels
import Testing


@Suite("Typed Unit Value Range Tests")
struct TypedUnitValueRangeTests {
    // Dummy unit for testing
    struct TestUnit: UnitProtocol, Equatable {
        var name: String
    }
    
    @Test("Initialization")
    func testInitialization() {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit1"), lowValue: 10.0, highValue: 20.0)
        #expect(range.unit == TestUnit(name: "TestUnit1"))
        #expect(range.lowValue == 10.0)
        #expect(range.highValue == 20.0)
    }
    
    @Test("Initialization with Integers")
    func testInitializationWithIntegers() {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit2"), lowValue: 10, highValue: 20)
        #expect(range.unit == TestUnit(name: "TestUnit2"))
        #expect(range.lowValue == 10.0)
        #expect(range.highValue == 20.0)
    }
    
    @Test("Equatable")
    func testEquatable() {
        let range1 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 10, highValue: 20)
        let range2 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 10, highValue: 20)
        let range3 = TypedUnitValueRange(unit: TestUnit(name: "TestUnit3"), lowValue: 15, highValue: 25)
        
        #expect(range1 == range2)
        #expect(range1 != range3)
    }
    
    @Test("Encoding and Decoding")
    func testEncodingAndDecoding() throws {
        let range = TypedUnitValueRange(unit: TestUnit(name: "TestUnit4"), lowValue: 10, highValue: 20)
        let encodedData = try JSONEncoder().encode(range)
        let decodedRange = try JSONDecoder().decode(TypedUnitValueRange<TestUnit>.self, from: encodedData)
        
        #expect(range == decodedRange)
    }
}
