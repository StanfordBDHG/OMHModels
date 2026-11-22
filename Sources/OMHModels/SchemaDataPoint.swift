//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

public import Foundation


/// A data point that pairs a ``Header`` with a schema-conforming body.
/// Generated from IEEE 1752.1 `data-point-1.0` (https://w3id.org/ieee/ieee-1752-schema/data-point.json)
public struct SchemaDataPoint<Body: Schema>: DataPoint {
    /// The header of the data point.
    public var header: Header
    /// The body of the data point.
    public var body: Body


    public init(header: Header, body: Body) {
        self.header = header
        self.body = body
    }

    /// Creates a data point whose header uses the body's schema identifier.
    /// - Parameters:
    ///   - body: The body of the data point.
    ///   - uuid: The identifier of the data point. Defaults to a new random UUID.
    ///   - sourceCreationDateTime: The date-time the data point was created. Defaults to now.
    ///   - modality: The modality whereby the measure is obtained.
    public init(
        body: Body,
        uuid: String = UUID().uuidString,
        sourceCreationDateTime: DateTime = DateTime(date: .now),
        modality: Modality? = nil
    ) {
        self.header = Header(uuid: uuid, sourceCreationDateTime: sourceCreationDateTime, schemaId: Body.schemaId, modality: modality)
        self.body = body
    }
}

extension SchemaDataPoint: Equatable where Body: Equatable {}
