//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A generic unit for HealthKit quantity samples, e.g., `count` or `mg/dL`.
public struct HealthKitUnit: UnitProtocol, Hashable {
    private enum LegacyCodingKeys: String, CodingKey {
        case unit
    }

    /// The unit string.
    public let unit: String


    public init(unit: String) {
        self.unit = unit
    }

    public init(from decoder: any Decoder) throws {
        if let unit = try? decoder.singleValueContainer().decode(String.self) {
            self.unit = unit
        } else {
            // Versions before 0.3.0 encoded the unit as a nested `{"unit": "..."}` object.
            let container = try decoder.container(keyedBy: LegacyCodingKeys.self)
            self.unit = try container.decode(String.self, forKey: .unit)
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(unit)
    }
}

/// A type representing a value paired with a unit for HealthKit quantity samples
public typealias HealthKitUnitValue = TypedUnitValue<HealthKitUnit>
