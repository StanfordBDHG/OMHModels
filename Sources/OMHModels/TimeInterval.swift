//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// This schema describes an interval of time. In the absence of a precise start and/or end time, the time interval can be described as a date + a part of the day (morning, afternoon, evening, night). No commitments are made as to whether the start or end time point itself is included in the interval (i.e., whether the defined interval includes the boundary point(s) or not).
/// Generated from IEEE 1752.1 `time-interval-1.0` (https://w3id.org/ieee/ieee-1752-schema/time-interval.json)
public struct TimeInterval: Schema, Equatable {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "time-interval", version: "1.0")
    
    public var startDateTime: DateTime?
    
    public var endDateTime: DateTime?
    
    public var duration: DurationUnitValue?
    
    public var date: Date?
    
    public var partOfDay: PartOfDay?

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

    public init(date: Date, partOfDay: PartOfDay) {
        self.date = date
        self.partOfDay = partOfDay
    }

    public static func == (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.startDateTime == rhs.startDateTime &&
        lhs.endDateTime == rhs.endDateTime &&
        lhs.duration == rhs.duration &&
        lhs.date == rhs.date &&
        lhs.partOfDay == rhs.partOfDay
    }
}
