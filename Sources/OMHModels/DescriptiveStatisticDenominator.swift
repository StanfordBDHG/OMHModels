//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The denominator of the descriptive statistic when the measures has an implicit duration. For example in the context of total sleep time, if the descriptive statistic is 'average' and the statistic denominator is 'd' the value describes average daily total sleep time during the period delimited by the effective time frame.
///
/// The values defined by IEEE 1752 are available as static properties. Schemas such as ``PhysicalActivity`` and ``TotalSleepTime`` also allow other values.
/// Generated from IEEE 1752.1 `descriptive-statistic-denominator-1.0` (https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic-denominator.json)
public struct DescriptiveStatisticDenominator: RawRepresentable, Schema, Hashable, ExpressibleByStringLiteral {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use the names defined by IEEE 1752
    /// Day
    public static let d: DescriptiveStatisticDenominator = "d"
    /// Week
    public static let wk: DescriptiveStatisticDenominator = "wk"
    /// Month
    public static let Mo: DescriptiveStatisticDenominator = "Mo"
    // swiftlint:enable identifier_name
    /// Episode
    public static let episode: DescriptiveStatisticDenominator = "episode"
    /// Meal
    public static let meal: DescriptiveStatisticDenominator = "meal"
    /// Session
    public static let session: DescriptiveStatisticDenominator = "session"

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "descriptive-statistic-denominator", version: "1.0")

    public let rawValue: String


    /// Creates a value from its raw value. Never fails; failable for source compatibility with the previous `enum`.
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}
