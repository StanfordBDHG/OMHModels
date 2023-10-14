//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

/// This schema represents a range of numerical values with a unit of measure.
/// Generated from IEEE 1752.1 `unit-value-range-1.0` (https://w3id.org/ieee/ieee-1752-schema/unit-value-range.json)
public struct TypedUnitValueRange<T: UnitProtocol>: Codable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case unit, lowValue, highValue
    }
    
    /// The unit of measure of the element. Allowed values are drawn from the Common synonyms (non-UCUM) column of [subset of] UCUM, SI and English units.
    public var unit: T
    
    /// The lower boundary of the range.
    public var lowValue: Double
    
    /// The upper boundary of the range.
    public var highValue: Double
    
    
    public init(unit: T, lowValue: Double, highValue: Double) {
        self.unit = unit
        self.lowValue = lowValue
        self.highValue = highValue
    }
    
    public init(unit: T, lowValue: Int, highValue: Int) {
        self.unit = unit
        self.lowValue = Double(lowValue)
        self.highValue = Double(highValue)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        unit = try container.decode(T.self, forKey: .unit)
        lowValue = try container.decode(Double.self, forKey: .lowValue)
        highValue = try container.decode(Double.self, forKey: .highValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unit, forKey: .unit)
        try container.encode(lowValue, forKey: .lowValue)
        try container.encode(highValue, forKey: .highValue)
    }
}

extension TypedUnitValueRange: Equatable where T: Equatable {
    public static func == (lhs: TypedUnitValueRange<T>, rhs: TypedUnitValueRange<T>) -> Bool {
        lhs.unit == rhs.unit &&
        lhs.lowValue == rhs.lowValue &&
        lhs.highValue == rhs.highValue
    }
}
