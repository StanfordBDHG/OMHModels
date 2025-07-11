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


@Suite("Time Interval Tests")
struct TimeIntervalTests {
    @Test("Time Interval with Start DateTime and Duration")
    func testTimeIntervalwithStartDateTimeAndDuration() {
        let startDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, duration: duration)
        
        #expect(timeInterval.startDateTime == startDateTime)
        #expect(timeInterval.duration == duration)
        #expect(timeInterval.endDateTime == nil)
        #expect(timeInterval.date == nil)
        #expect(timeInterval.partOfDay == nil)
    }
    
    @Test("Time Interval with End DateTime and Duration")
    func testTimeIntervalWithEndDateTimeAndDuration() {
        let endDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(endDateTime: endDateTime, duration: duration)
        
        #expect(timeInterval.endDateTime == endDateTime)
        #expect(timeInterval.duration == duration)
        #expect(timeInterval.startDateTime == nil)
        #expect(timeInterval.date == nil)
        #expect(timeInterval.partOfDay == nil)
    }
    
    @Test("Init with Start DateTime and End DateTime")
    func testInitWithStartDateTimeAndEndDateTime() {
        let startDateTime = DateTime(date: Date(timeIntervalSince1970: 0)) // Substitute with your DateTime initialization
        let endDateTime = DateTime(date: Date(timeIntervalSince1970: 10)) // Substitute with your DateTime initialization
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, endDateTime: endDateTime)
        
        #expect(timeInterval.startDateTime == startDateTime)
        #expect(timeInterval.endDateTime == endDateTime)
        #expect(timeInterval.duration == nil)
        #expect(timeInterval.date == nil)
        #expect(timeInterval.partOfDay == nil)
    }
    
    @Test("Init with Date and Part of Day")
    func testInitWithDateAndPartOfDay() {
        let date = Date()
        let partOfDay = PartOfDay.morning
        
        let timeInterval = TimeInterval(date: date, partOfDay: partOfDay)
        
        #expect(timeInterval.date == date)
        #expect(timeInterval.partOfDay == partOfDay)
        #expect(timeInterval.startDateTime == nil)
        #expect(timeInterval.endDateTime == nil)
        #expect(timeInterval.duration == nil)
    }
}
