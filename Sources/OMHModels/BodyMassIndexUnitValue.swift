//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Units for a body mass index (BMI) measurement
public enum BodyMassIndexUnit: String, UnitProtocol {
    case kilogramsPerMeterSquared = "kg/m^2"
}

/// A type representing a value paired with a unit specific to the body mass index calculation
public typealias BodyMassIndexUnitValue = TypedUnitValue<BodyMassIndexUnit>
