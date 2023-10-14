//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The unit of measure of the element. Basic unit is meter (m) [ http://unitsofmeasure.org/ucum.html#para-28 ]. Allowed values are drawn from the SI Length Units and English Length Units Common Synonyms (non-UCUM). The valid UCUM code is different for inch ([in_i]), foot ([ft_i]), yard ([yd_i]) and mile ([mi_i]).
public enum LengthUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case fm
    case pm
    case nm
    case um
    case mm
    case cm
    case m
    case km
    case `in`
    case ft
    case yd
    case mi
}

/// A type representing a value paired with a unit specific to length measurements
/// Generated from IEEE 1752.1 `length-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/length-unit-value.json)
public typealias LengthUnitValue = TypedUnitValue<LengthUnit>
