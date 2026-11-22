//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

public import Foundation


/// This schema describes an interval of time, either as a start date-time and a duration, an end date-time and a duration,
/// or a start and an end date-time. No commitments are made as to whether the start or end time point itself is included in the interval
/// (i.e., whether the defined interval includes the boundary point(s) or not).
///
/// - Note: This type shares its name with `Foundation.TimeInterval`. In files that import Foundation, refer to it as `OMHModels.TimeInterval`
///   where the compiler reports an ambiguity.
/// Generated from IEEE 1752.1 `time-interval-1.0` (https://w3id.org/ieee/ieee-1752-schema/time-interval.json)
public struct TimeInterval: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case startDateTime = "start_date_time"
        case endDateTime = "end_date_time"
        case duration
        case date
        case partOfDay = "part_of_day"
    }

    private static let fullDateStyle = Date.ISO8601FormatStyle(timeZone: .gmt).year().month().day()

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "time-interval", version: "1.0")
    
    public var startDateTime: DateTime?
    
    public var endDateTime: DateTime?
    
    public var duration: DurationUnitValue?

    private var fullDate: Date?

    /// The `YYYY-MM-DD` representation the date was decoded from, if any, so it's encoded the same way.
    private var fullDateString: String?

    private var fullDatePartOfDay: PartOfDay?

    /// The date of a time interval described as a date and a part of the day.
    @available(*, deprecated, message: "IEEE 1752 doesn't define time intervals with a date and a part of the day") public var date: Date? {
        get { fullDate }
        set {
            fullDate = newValue
            fullDateString = nil
        }
    }

    /// The part of the day of a time interval described as a date and a part of the day.
    @available(*, deprecated, message: "IEEE 1752 doesn't define time intervals with a date and a part of the day") public var partOfDay: PartOfDay? {
        get { fullDatePartOfDay }
        set { fullDatePartOfDay = newValue }
    }


    public init(startDateTime: DateTime, duration: DurationUnitValue) {
        self.startDateTime = startDateTime
        self.duration = duration
    }

    public init(endDateTime: DateTime, duration: DurationUnitValue) {
        self.endDateTime = endDateTime
        self.duration = duration
    }

    public init(startDateTime: DateTime, endDateTime: DateTime) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }

    /// Creates a time interval from a date and a part of the day.
    @available(*, deprecated, message: "IEEE 1752 doesn't define time intervals with a date and a part of the day")
    public init(date: Date, partOfDay: PartOfDay) {
        self.fullDate = date
        self.fullDatePartOfDay = partOfDay
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        startDateTime = try container.decodeIfPresent(DateTime.self, forKey: .startDateTime)
        endDateTime = try container.decodeIfPresent(DateTime.self, forKey: .endDateTime)
        duration = try container.decodeIfPresent(DurationUnitValue.self, forKey: .duration)
        fullDatePartOfDay = try container.decodeIfPresent(PartOfDay.self, forKey: .partOfDay)
        if let fullDateString = try? container.decodeIfPresent(String.self, forKey: .date) {
            // Open mHealth `time-interval-1.0` represents the date as a `YYYY-MM-DD` full date.
            fullDate = try Self.fullDateStyle.parse(fullDateString)
            self.fullDateString = fullDateString
        } else {
            fullDate = try container.decodeIfPresent(Date.self, forKey: .date)
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(startDateTime, forKey: .startDateTime)
        try container.encodeIfPresent(endDateTime, forKey: .endDateTime)
        try container.encodeIfPresent(duration, forKey: .duration)
        if let fullDateString {
            try container.encode(fullDateString, forKey: .date)
        } else {
            try container.encodeIfPresent(fullDate, forKey: .date)
        }
        try container.encodeIfPresent(fullDatePartOfDay, forKey: .partOfDay)
    }
}
