//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


class TimeWindowTests: XCTestCase {
    func testEncodeAndDecodeDuration() throws {
        let originalValue = TimeWindow.duration(
            TypedUnitValue(
                unit: .sec,
                value: 30.0
            )
        )
        
        let data = try JSONEncoder().encode(originalValue)
        let decodedValue = try JSONDecoder().decode(TimeWindow.self, from: data)
        
        XCTAssertEqual(originalValue, decodedValue)
    }

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
        
        XCTAssertEqual(originalValue, decodedValue)
    }

    func testDecodeInvalidData() throws {
        let invalidData = try XCTUnwrap("Invalid Data".data(using: .utf8))
        XCTAssertThrowsError(try JSONDecoder().decode(TimeWindow.self, from: invalidData))
    }
}
