//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to length measurements
/// Generated from IEEE 1752.1 `length-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/length-unit-value.json)
public typealias LengthUnitValue = TypedUnitValue<LengthUnit>

public enum LengthUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case fm
    case pm
    case nm
    case um
    case mm
    case cm
    case m
    case km
    case `in`
    case ft
    case yd
    case mi
}
