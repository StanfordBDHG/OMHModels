//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Generated from Open mHealth `omh:part-of-day:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_part-of-day)
public enum PartOfDay: String, Codable, Sendable {
    case morning
    case afternoon
    case evening
    case night
}
