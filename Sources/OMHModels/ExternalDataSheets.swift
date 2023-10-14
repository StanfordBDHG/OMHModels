//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Reference(s) to external documentation regarding the component(s) relevant to describe the collection, computation, use, etc. of this datapoint or data series, e.g., software, algorithm, study protocol, etc.
public struct ExternalDataSheet: Codable, Sendable, Equatable {
    /// The type of component described or documented by the referenced datasheet, e.g., software, hardware, study.
    public var datasheetType: String?
    
    /// International Resource Identifier (IRI) of applicable datasheet(s). The expectation is that the IRI will convey resolvable location and access information for the resource identified resource.
    public var datasheetReference: String
    
    
    // swiftlint:disable function_default_parameter_at_end
    // We disable this rule because the parameter order is based on the schema.
    public init(
        datasheetType: String? = nil,
        datasheetReference: String
    ) {
        self.datasheetType = datasheetType
        self.datasheetReference = datasheetReference
    }
}
