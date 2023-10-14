//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// An enumeration representing different types of statistical measures that can be represented in data points
/// Generated from IEEE 1752.1 `descriptive-statistic-1.0` (https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic.json)
public enum DescriptiveStatistic: String, Schema {
    case average
    case count
    case maximum
    case median
    case minimum
    case standardDeviation = "standard deviation"
    case sum
    case variance
    case twentiethPercentile = "20th percentile"
    case eightiethPercentile = "80th percentile"
    case lowerQuartile = "lower quartile"
    case upperQuartile = "upper quartile"
    case quartileDeviation = "quartile deviation"
    case firstQuintile = "1st quintile"
    case secondQuintile = "2nd quintile"
    case thirdQuintile = "3rd quintile"
    case fourthQuintile = "4th quintile"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "descriptive-statistic", version: "1.0")
}
