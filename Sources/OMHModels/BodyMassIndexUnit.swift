//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to the body mass index calculation
public typealias BodyMassIndexUnitValue = TypedUnitValue<BodyMassIndexUnit>

public enum BodyMassIndexUnit: String, UnitProtocol {
    case kilogramsPerMeterSquared = "kg/m^2"
}
