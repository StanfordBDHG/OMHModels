//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Generated from IEEE 1752.1 `frequency-unit-value:1.0` (https://w3id.org/ieee/ieee-1752-schema/frequency-unit-value.json)
public struct FrequencyUnitValue: Schema, Equatable {
    /// The IEEE schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "frequency-unit-value", version: "1.0")
    
    /// Time window in which the event occurs or should occur: e.g., in twice a day every other day
    public var timeWindow: TimeWindow
    
    /// How many times the event occurs or should occur in the time window
    public var numberOfTimes: Int
}
