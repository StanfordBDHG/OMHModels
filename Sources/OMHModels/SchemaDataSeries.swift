//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

public import Foundation


/// A data series that pairs a ``Header`` with multiple bodies of the same schema.
/// Generated from IEEE 1752.1 `data-series-1.0` (https://w3id.org/ieee/ieee-1752-schema/data-series.json)
public struct SchemaDataSeries<Body: Schema>: DataSeries {
    /// The header of the data series.
    public var header: Header
    /// The bodies of the data series.
    public var body: [Body]


    public init(header: Header, body: [Body]) {
        self.header = header
        self.body = body
    }

    /// Creates a data series whose header uses the body's schema identifier.
    /// - Parameters:
    ///   - body: The bodies of the data series.
    ///   - uuid: The identifier of the data series. Defaults to a new random UUID.
    ///   - sourceCreationDateTime: The date-time the data series was created. Defaults to now.
    ///   - modality: The modality whereby the measures are obtained.
    public init(
        body: [Body],
        uuid: String = UUID().uuidString,
        sourceCreationDateTime: DateTime = DateTime(date: .now),
        modality: Modality? = nil
    ) {
        self.header = Header(uuid: uuid, sourceCreationDateTime: sourceCreationDateTime, schemaId: Body.schemaId, modality: modality)
        self.body = body
    }
}

extension SchemaDataSeries: Equatable where Body: Equatable {}
