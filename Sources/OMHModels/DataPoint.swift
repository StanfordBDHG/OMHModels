//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A protocol for an IEEE 1752 data point
/// Generated from IEEE 1752.1 `data-point-1.0` (https://w3id.org/ieee/ieee-1752-schema/data-point.json)
public protocol DataPoint<Body>: Sendable, Codable {
    associatedtype Body: Schema
    
    
    var header: Header { get }
    var body: Body { get set }
}
