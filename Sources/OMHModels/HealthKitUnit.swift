//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit for HealthKit quantity samples
public typealias HealthKitUnitValue = TypedUnitValue<HealthKitUnit>

public struct HealthKitUnit: UnitProtocol {
    let unit: String
    
    public init(unit: String) {
        self.unit = unit
    }
}
