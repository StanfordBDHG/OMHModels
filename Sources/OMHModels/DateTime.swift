//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Generated from IEEE 1752.1 `date-time-1.0` (https://w3id.org/ieee/ieee-1752-schema/date-time.json)
public struct DateTime: Schema, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "date-time", version: "1.0")

    let value: String // The value should be in ISO8601 format as per the schema.


    public init(date: Date) {
        let formatter = ISO8601DateFormatter()
        self.value = formatter.string(from: date)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
