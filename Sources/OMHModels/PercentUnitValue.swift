//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Units for a percentage
public enum PercentUnit: String, UnitProtocol, Hashable {
    case percent = "%"
}

/// A type representing a percentage
/// Generated from IEEE 1752.1 `percent-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/percent-unit-value.json)
public typealias PercentUnitValue = TypedUnitValue<PercentUnit>
