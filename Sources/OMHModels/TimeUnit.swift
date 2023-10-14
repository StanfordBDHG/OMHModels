//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Allowed time units are drawn from the HL7 UCUM Common Synonyms code set (https://download.hl7.de/documents/ucum/ucumdata.html)
public enum TimeUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case ps
    case ns
    case us
    case ms
    case sec
    case min
    case h
    case d
    case wk
    case Mo
    case yr
}
