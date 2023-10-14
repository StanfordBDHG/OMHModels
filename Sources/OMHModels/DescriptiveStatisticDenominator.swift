//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// The denominator of the descriptive statistic when the measures has an implicit duration. For example in the context of total sleep time, if the descriptive statistic is 'average' and the statistic denominator is 'd' the value describes average daily total sleep time during the period delimited by the effective time frame.
/// Generated from IEEE 1752.1 `physical-activity-1.0` (https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic-denominator.json)
public enum DescriptiveStatisticDenominator: String, Schema {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by IEEE 1752
    case d
    case wk
    case Mo
    case episode
    case meal
    case session
    
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "descriptive-statistic-denominator", version: "1.0")
}
