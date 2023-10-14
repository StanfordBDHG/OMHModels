//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The set of allowable values describing the source of a specimen analyzed.
/// The value set is not complete. More values are added as use cases require.
/// Generated from Open mHealth `omh:specimen-source:2.1` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_specimen-source)
public enum SpecimenSource: String, Codable, Sendable {
    case breath
    case capillaryBlood = "capillary blood"
    case interstitialFluid = "interstitial fluid"
    case saliva
    case sweat
    case tears
    case urine
}
