//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to the rate of flow of supplemental oxygen therapy
public typealias SupplementalOxygenFlowRateUnitValue = TypedUnitValue<SupplementalOxygenFlowRateUnit>

public enum SupplementalOxygenFlowRateUnit: String, UnitProtocol {
    case litersPerMinute = "L/min"
}
