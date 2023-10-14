//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The modality whereby the measure is obtained.
public enum Modality: String, Sendable, Codable {
    case sensed = "sensed"
    case selfReported = "self-reported"
}
