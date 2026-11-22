//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

public import Foundation


/// Metadata representing the source of a data point
@available(*, deprecated, message: "AcquisitionProvenance isn't part of IEEE 1752 and can't be created outside of OMHModels")
public struct AcquisitionProvenance: Sendable, Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceCreationDateTime = "source_creation_date_time"
        case sourceLastModificationDateTime = "source_last_modification_date_time"
        case modality
    }

    /// The name of the source of the data.
    public var sourceName: String

    /// The date time (timestamp) of data creation at the source.
    public var sourceCreationDateTime: Date?

    /// The date time (timestamp) of last data modification at the source.
    public var sourceLastModificationDateTime: Date?

    /// The `Modality` whereby the measure is obtained.
    public var modality: Modality?
    
    
    init(
        sourceName: String,
        sourceCreationDateTime: Date? = nil,
        modality: Modality? = nil
    ) {
        self.sourceName = sourceName
        self.sourceCreationDateTime = sourceCreationDateTime
        self.modality = modality
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        sourceName = try container.decode(String.self, forKey: .sourceName)
        sourceCreationDateTime = try container.decodeIfPresent(Date.self, forKey: .sourceCreationDateTime)
        sourceLastModificationDateTime = try container.decodeIfPresent(Date.self, forKey: .sourceLastModificationDateTime)
        modality = try container.decodeIfPresent(Modality.self, forKey: .modality)
    }
}
