//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to blood glucose measurements.
public typealias BloodGlucoseUnitValue = TypedUnitValue<BloodGlucoseUnit>

/// Units for a blood glucose measurement
public enum BloodGlucoseUnit: String, UnitProtocol {
    case milligramsPerDeciliter = "mg/dL"
    case millimolesPerLiter = "mmol/L"
}
