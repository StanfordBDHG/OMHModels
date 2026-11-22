//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The unit of measure of a plane angle. Open mHealth only allows degrees.
public enum PlaneAngleUnit: String, UnitProtocol, Sendable {
    case deg
}

/// A type representing a value paired with a unit specific to plane angle measurements
/// Generated from Open mHealth `omh:plane-angle-unit-value:1.1` (https://w3id.org/openmhealth/schemas/omh/plane-angle-unit-value-1.1.json)
public typealias PlaneAngleUnitValue = TypedUnitValue<PlaneAngleUnit>
