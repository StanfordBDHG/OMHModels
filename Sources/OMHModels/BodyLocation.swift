//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A location on the body. Values from the Anatomical or acquired body structure hierarchy of SNOMED can be added as needed.
/// Generated from Open mHealth `omh:body-location:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-location)
public enum BodyLocation: String, Schema {
    case leftAnkle = "left ankle"
    case rightAnkle = "right ankle"
    case leftHip = "left hip"
    case rightHip = "right hip"
    case leftThigh = "left thigh"
    case rightThigh = "right thigh"
    case leftThorax = "left thorax"
    case middleLeftThorax = "middle left thorax"
    case leftUpperArm = "left upper arm"
    case rightUpperArm = "right upper arm"
    case leftWrist = "left wrist"
    case rightWrist = "right wrist"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-location", version: "1.0")
}
