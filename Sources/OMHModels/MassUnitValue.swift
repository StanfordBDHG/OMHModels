//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to mass measurements
public typealias MassUnitValue = TypedUnitValue<MassUnit>

public enum MassUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case fg
    case pg
    case ng
    case ug
    case mg
    case g
    case kg
    case metricTon = "Metric Ton"
    case gr
    case oz
    case lb
    case ton = "Ton"
}
