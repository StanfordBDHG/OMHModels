//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a respiratory rate measurement
public enum RespiratoryRateUnit: String, UnitProtocol {
    case breathsPerMinute = "breaths/min"
}

/// A type representing a value paired with a unit specific to heart rate measurements
public typealias RespiratoryRateUnitValue = TypedUnitValue<RespiratoryRateUnit>
