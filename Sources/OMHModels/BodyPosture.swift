//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Set of allowable values describing the posture of the body (e.g., during a measurement).
/// Generated from IEEE 1752.1 `body-posture-1.0` (https://w3id.org/ieee/ieee-1752-schema/body-posture.json)
public enum BodyPosture: String, Schema {
    case sitting
    case lyingDown = "lying down"
    case standing
    case semiRecumbent = "semi-recumbent"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-posture", version: "1.0")
}
