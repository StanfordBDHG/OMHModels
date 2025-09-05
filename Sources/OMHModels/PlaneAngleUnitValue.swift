//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The unit of measure of the element. Basic unit is radian (rad). Allowed values are drawn from the SI Plane Angle Units.
public enum PlaneAngleUnit: String, UnitProtocol {
    case rad
    case deg
}

/// A type representing a value paired with a unit specific to plane angle measurements
/// Generated from IEEE 1752.1 `plane-angle-unit-value-1.0` 
public typealias PlaneAngleUnitValue = TypedUnitValue<PlaneAngleUnit>
