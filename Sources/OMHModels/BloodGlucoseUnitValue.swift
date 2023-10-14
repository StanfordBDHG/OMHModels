//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a blood glucose measurement
public enum BloodGlucoseUnit: String, UnitProtocol {
    case milligramsPerDeciliter = "mg/dL"
    case millimolesPerLiter = "mmol/L"
}

/// A type representing a value paired with a unit specific to blood glucose measurements.
public typealias BloodGlucoseUnitValue = TypedUnitValue<BloodGlucoseUnit>
