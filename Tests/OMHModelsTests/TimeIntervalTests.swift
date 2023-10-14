//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class TimeIntervalTests: XCTestCase {
    func testTimeIntervalwithStartDateTimeAndDuration() {
        let startDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, duration: duration)
        
        XCTAssertEqual(timeInterval.startDateTime, startDateTime)
        XCTAssertEqual(timeInterval.duration, duration)
        XCTAssertNil(timeInterval.endDateTime)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }
    
    func testTimeIntervalWithEndDateTimeAndDuration() {
        let endDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(endDateTime: endDateTime, duration: duration)
        
        XCTAssertEqual(timeInterval.endDateTime, endDateTime)
        XCTAssertEqual(timeInterval.duration, duration)
        XCTAssertNil(timeInterval.startDateTime)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }
    
    func testInitWithStartDateTimeAndEndDateTime() {
        let startDateTime = DateTime(date: Date(timeIntervalSince1970: 0)) // Substitute with your DateTime initialization
        let endDateTime = DateTime(date: Date(timeIntervalSince1970: 10)) // Substitute with your DateTime initialization
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, endDateTime: endDateTime)
        
        XCTAssertEqual(timeInterval.startDateTime, startDateTime)
        XCTAssertEqual(timeInterval.endDateTime, endDateTime)
        XCTAssertNil(timeInterval.duration)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }
    
    func testInitWithDateAndPartOfDay() {
        let date = Date()
        let partOfDay = PartOfDay.morning
        
        let timeInterval = TimeInterval(date: date, partOfDay: partOfDay)
        
        XCTAssertEqual(timeInterval.date, date)
        XCTAssertEqual(timeInterval.partOfDay, partOfDay)
        XCTAssertNil(timeInterval.startDateTime)
        XCTAssertNil(timeInterval.endDateTime)
        XCTAssertNil(timeInterval.duration)
    }
}
