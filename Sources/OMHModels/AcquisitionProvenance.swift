//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Metadata representing the source of a data point
public struct AcquisitionProvenance: Sendable, Codable {
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
}
