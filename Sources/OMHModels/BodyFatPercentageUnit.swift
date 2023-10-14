//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to body fat percentage
public typealias BodyFatPercentageUnitValue = TypedUnitValue<BodyFatPercentageUnit>

public enum BodyFatPercentageUnit: String, UnitProtocol {
    case percent = "%"
}
