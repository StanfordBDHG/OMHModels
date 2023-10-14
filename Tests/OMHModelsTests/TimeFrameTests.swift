//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class TimeFrameTests: XCTestCase {
    var startDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 0) // Date Stanford University opened (https://www.stanford.edu/about/history/)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    var endDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 42)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    func testTimeFrameDateTimeInitializer() {
        let sampleDateTime = DateTime(date: .now)
        let timeFrame = TimeFrame(dateTime: sampleDateTime)
        
        XCTAssertNotNil(timeFrame.dateTime)
        XCTAssertNil(timeFrame.timeInterval)
    }
    
    func testTimeFrameEquality() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))
        
        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame3 = TimeFrame(timeInterval: sampleTimeInterval)
        
        XCTAssertEqual(timeFrame1, timeFrame2)
        XCTAssertNotEqual(timeFrame1, timeFrame3)
    }
    
    func testTimeFrameEncoding() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))
        
        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(timeInterval: sampleTimeInterval)
        
        let encoder = JSONEncoder()
        
        do {
            let dateTimeData = try encoder.encode(timeFrame1)
            if let encodedString = String(data: dateTimeData, encoding: .utf8) {
                XCTAssertTrue(encodedString.contains("date_time"))
            } else {
                XCTFail("Failed to convert encoded data to string for dateTime")
            }
        } catch {
            XCTFail("Failed to encode TimeFrame for dateTime: \(error)")
        }
        
        do {
            let timeIntervalData = try encoder.encode(timeFrame2)
            if let encodedString = String(data: timeIntervalData, encoding: .utf8) {
                XCTAssertTrue(encodedString.contains("time_interval"))
            } else {
                XCTFail("Failed to convert encoded data to string for timeInterval")
            }
        } catch {
            XCTFail("Failed to encode TimeFrame for timeInterval: \(error)")
        }
    }
    
    func testTimeFrameDecoding() throws {
        // A time frame that consists of a single date_time
        guard let dateTimeJson = """
            {
                "date_time": "2013-02-05T07:25:00.123Z"
            }
            """.data(using: .utf8) else {
            XCTFail("Failed to convert dateTime JSON string to Data")
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
            XCTFail("Failed to convert timeInterval JSON string to Data")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let dateTimeTimeFrame = try decoder.decode(TimeFrame.self, from: dateTimeJson)
            XCTAssertNotNil(dateTimeTimeFrame.dateTime)
            XCTAssertNil(dateTimeTimeFrame.timeInterval)
        } catch {
            XCTFail("Failed to decode TimeFrame for dateTime: \(error)")
        }
        
        do {
            let timeIntervalTimeFrame = try decoder.decode(TimeFrame.self, from: timeIntervalJson)
            XCTAssertNil(timeIntervalTimeFrame.dateTime)
            XCTAssertNotNil(timeIntervalTimeFrame.timeInterval)
        } catch {
            XCTFail("Failed to decode TimeFrame for timeInterval: \(error)")
        }
    }
}
