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


@Suite("Time Frame Tests")
struct TimeFrameTests {
    var startDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 0) // Date Stanford University opened (https://www.stanford.edu/about/history/)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
    }
    
    var endDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 42)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
    }
    
    @Test("Time Frame DateTime Initializer")
    func testTimeFrameDateTimeInitializer() {
        let sampleDateTime = DateTime(date: .now)
        let timeFrame = TimeFrame(dateTime: sampleDateTime)
        
        #expect(timeFrame.dateTime != nil)
        #expect(timeFrame.timeInterval == nil)
    }
    
    @Test("Time Frame Equality")
    func testTimeFrameEquality() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))
        
        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame3 = TimeFrame(timeInterval: sampleTimeInterval)
        
        #expect(timeFrame1 == timeFrame2)
        #expect(timeFrame1 != timeFrame3)
    }
    
    @Test("Time Frame Encoding")
    func testTimeFrameEncoding() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))
        
        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(timeInterval: sampleTimeInterval)
        
        let encoder = JSONEncoder()
        
        do {
            let dateTimeData = try encoder.encode(timeFrame1)
            if let encodedString = String(data: dateTimeData, encoding: .utf8) {
                #expect(encodedString.contains("date_time"))
            } else {
                Issue.record("Failed to convert encoded data to string for dateTime")
            }
        } catch {
            Issue.record("Failed to encode TimeFrame for dateTime: \(error)")
        }
        
        do {
            let timeIntervalData = try encoder.encode(timeFrame2)
            if let encodedString = String(data: timeIntervalData, encoding: .utf8) {
                #expect(encodedString.contains("time_interval"))
            } else {
                Issue.record("Failed to convert encoded data to string for timeInterval")
            }
        } catch {
            Issue.record("Failed to encode TimeFrame for timeInterval: \(error)")
        }
    }
    
    @Test("Time Frame Decoding")
    func testTimeFrameDecoding() throws {
        // A time frame that consists of a single date_time
        guard let dateTimeJson = """
            {
                "date_time": "2013-02-05T07:25:00.123Z"
            }
            """.data(using: .utf8) else {
            Issue.record("Failed to convert dateTime JSON string to Data")
            return
        }
        
        // A time interval that consists of a duration and end_date_time
        guard let timeIntervalJson = """
            {
                "time_interval": {
                    "duration": {
                        "value": 10,
                        "unit": "d"
                    },
                    "end_date_time": "2013-02-05T07:35:00Z"
                }
            }
            """.data(using: .utf8) else {
            Issue.record("Failed to convert timeInterval JSON string to Data")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let dateTimeTimeFrame = try decoder.decode(TimeFrame.self, from: dateTimeJson)
            #expect(dateTimeTimeFrame.dateTime != nil)
            #expect(dateTimeTimeFrame.timeInterval == nil)
        } catch {
            Issue.record("Failed to decode TimeFrame for dateTime: \(error)")
        }
        
        do {
            let timeIntervalTimeFrame = try decoder.decode(TimeFrame.self, from: timeIntervalJson)
            #expect(timeIntervalTimeFrame.dateTime == nil)
            #expect(timeIntervalTimeFrame.timeInterval != nil)
        } catch {
            Issue.record("Failed to decode TimeFrame for timeInterval: \(error)")
        }
    }
}

