//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Generated from IEEE 1752.1 `kcal-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/speed-unit-value.json)
public typealias KcalUnitValue = TypedUnitValue<KcalUnit>

public enum KcalUnit: String, UnitProtocol {
    case kcal
}
