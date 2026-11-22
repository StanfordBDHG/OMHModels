//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

public import Foundation


/// Errors that can occur when creating a ``DateTime``.
public enum DateTimeError: Error, Equatable {
    /// The string is not an RFC 3339 date-time with a time zone offset.
    case invalidFormat(String)
}


/// A date-time in RFC 3339 format, including a time zone offset (e.g., `2020-02-05T07:25:00-08:00`).
/// Generated from IEEE 1752.1 `date-time-1.0` (https://w3id.org/ieee/ieee-1752-schema/date-time.json)
public struct DateTime: Schema, Hashable {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "date-time", version: "1.0")

    /// The string representation, exactly as created or decoded.
    public let value: String

    /// The point in time this date-time represents, or `nil` if ``value`` isn't a valid RFC 3339 date-time.
    public var date: Date? {
        // RFC 3339 allows a lowercase `t` and `z`.
        try? Date.ISO8601FormatStyle(includingFractionalSeconds: true).parse(value.uppercased())
    }


    /// Creates a date-time for the given date.
    /// - Parameters:
    ///   - date: The point in time.
    ///   - timeZone: The time zone whose offset is used in the string representation. Defaults to UTC.
    ///   - includingFractionalSeconds: Whether to include milliseconds in the string representation. Defaults to `false`.
    public init(date: Date, timeZone: TimeZone = .gmt, includingFractionalSeconds: Bool = false) {
        let style = Date.ISO8601FormatStyle(
            timeZoneSeparator: .colon,
            includingFractionalSeconds: includingFractionalSeconds,
            timeZone: timeZone
        )
        self.value = date.formatted(style)
    }

    /// Creates a date-time from an RFC 3339 string (e.g., `2020-02-05T07:25:00-08:00`).
    /// - Throws: ``DateTimeError/invalidFormat(_:)`` if the string is not a valid RFC 3339 date-time.
    public init(_ value: String) throws {
        self.value = value
        guard date != nil else {
            throw DateTimeError.invalidFormat(value)
        }
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
