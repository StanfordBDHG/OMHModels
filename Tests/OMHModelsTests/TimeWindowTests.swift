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


@Suite("Time Window Tests")
struct TimeWindowTests {
    @Test("Encode and Decode Duration")
    func testEncodeAndDecodeDuration() throws {
        let originalValue = TimeWindow.duration(
            TypedUnitValue(
                unit: .sec,
                value: 30.0
            )
        )
        
        let data = try JSONEncoder().encode(originalValue)
        let decodedValue = try JSONDecoder().decode(TimeWindow.self, from: data)
        
        #expect(originalValue == decodedValue)
    }

    @Test("Encode and Decode Duration Range")
    func testEncodeAndDecodeDurationRange() throws {
        let originalValue = TimeWindow.durationRange(
            TypedUnitValueRange(
                unit: .min,
                lowValue: 10.0,
                highValue: 30.0
            )
        )
        
        let data = try JSONEncoder().encode(originalValue)
        let decodedValue = try JSONDecoder().decode(TimeWindow.self, from: data)
        
        #expect(originalValue == decodedValue)
    }

    @Test("Decode Invalid Data")
    func testDecodeInvalidData() throws {
        guard let invalidData = "Invalid Data".data(using: .utf8) else {
            Issue.record("Failed to create invalid data")
            return
        }
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(TimeWindow.self, from: invalidData)
        }
    }
}
