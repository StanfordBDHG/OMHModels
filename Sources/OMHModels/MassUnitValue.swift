//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The unit of measure of the element. Basic unit is gram (g) [ http://unitsofmeasure.org/ucum.html#para-28 ]. Allowed values are drawn from the SI Mass Units and English Mass Units Common Synonyms (non-UCUM) columns of the 'Mass Units' section. The valid UCUM code is different for metric ton (t), grain ([gr]), ounce ([oz_av]), pound ([lb_av]) and Ton ([ston_av]).
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

/// A type representing a value paired with a unit specific to mass measurements
public typealias MassUnitValue = TypedUnitValue<MassUnit>
