//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a step count measurement
public enum StepCountUnit: String, UnitProtocol {
    case steps
}

/// A type representing a value paired with a unit specific to step count measurements
public typealias StepCountUnitValue = TypedUnitValue<StepCountUnit>
