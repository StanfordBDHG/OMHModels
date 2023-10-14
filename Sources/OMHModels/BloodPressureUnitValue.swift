//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a blood pressure measurement
public enum BloodPressureUnit: String, UnitProtocol {
    case mmHg
}

/// A type representing a value paired with a unit specific to blood pressure measurements
public typealias BloodPressureUnitValue = TypedUnitValue<BloodPressureUnit>
