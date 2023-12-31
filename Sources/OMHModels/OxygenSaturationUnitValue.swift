//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation

/// Units for an oxygen saturation measurement
public enum OxygenSaturationUnit: String, UnitProtocol {
    case percent = "%"
}

/// A type representing a value paired with a unit specific to oxygen saturation measurements
public typealias OxygenSaturationUnitValue = TypedUnitValue<OxygenSaturationUnit>
