//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A protocol for an IEEE 1752 data series, i.e., a header and multiple bodies that share it
/// Generated from IEEE 1752.1 `data-series-1.0` (https://w3id.org/ieee/ieee-1752-schema/data-series.json)
public protocol DataSeries<Body>: Sendable, Codable {
    associatedtype Body: Schema


    var header: Header { get }
    var body: [Body] { get set }
}
