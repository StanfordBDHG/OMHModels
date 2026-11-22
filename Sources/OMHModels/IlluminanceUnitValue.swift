//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


// swiftlint:disable identifier_name
// We disable this rule because we must use the unit names defined by IEEE 1752
/// Units for illuminance
public enum IlluminanceUnit: String, UnitProtocol, Hashable {
    case lx
}
// swiftlint:enable identifier_name

/// A type representing an illuminance
/// Generated from IEEE 1752.1 `illuminance-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/illuminance-unit-value.json)
public typealias IlluminanceUnitValue = TypedUnitValue<IlluminanceUnit>
