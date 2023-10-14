//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// This schema represents the header of a data point or data series.
/// Generated from IEEE 1752.1 `header-1.0` (https://w3id.org/ieee/ieee-1752-schema/header.json)
public struct Header: Codable, Sendable {
    /// The identifier of this data point - should be a globally unique value.
    public var uuid: String

    /// The schema identifier of the body of the data point.
    public var schemaId: SchemaId
    
    /// The date time this data point was created on the system where data is stored.
    public var sourceCreationDateTime: DateTime
    
    /// The modality whereby the measure is obtained.
    public var modality: Modality?
    
    /// The rate at which measures are acquired.
    public var acquisitionRate: FrequencyUnitValue?
    
    /// References to external documentation
    public var externalDatasheets: [ExternalDataSheet]

    // swiftlint:disable function_default_parameter_at_end
    // We disable this rule because the parameter order is based on the schema.
    public init (
        uuid: String = UUID().uuidString,
        sourceCreationDateTime: DateTime,
        schemaId: SchemaId,
        modality: Modality? = nil,
        acquisitionRate: FrequencyUnitValue? = nil,
        externalDatasheets: [ExternalDataSheet] = []
    ) {
        self.uuid = uuid
        self.sourceCreationDateTime = sourceCreationDateTime
        self.schemaId = schemaId
        self.modality = modality
        self.acquisitionRate = acquisitionRate
        self.externalDatasheets = externalDatasheets
    }
}
