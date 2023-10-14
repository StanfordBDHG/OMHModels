//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a heart rate measurement
public enum HeartRateUnit: String, UnitProtocol {
    case beatsPerMinute = "beats/min"
}

/// A type representing a value paired with a unit specific to heart rate measurements
public typealias HeartRateUnitValue = TypedUnitValue<HeartRateUnit>
