//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Allowed values are drawn from the Temperature Units Common Synonyms (non-UCUM). The valid UCUM code is different for Celsius (C) and Fahrenheit ([degF]). (http://download.hl7.de/documents/ucum/ucumdata.html)
public enum TemperatureUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case K
    case F
    case C
}

/// A type representing a value paired with a unit specific to temperature measurements
/// Generated from IEEE 1752.1 `temperature-unit-value` (https://w3id.org/ieee/ieee-1752-schema/temperature-unit-value.json)
public typealias TemperatureUnitValue = TypedUnitValue<TemperatureUnit>
