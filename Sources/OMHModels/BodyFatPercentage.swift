//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Body fat percentage
/// Generated from Open mHealth `omh:body-fat-percentage:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-fat-percentage)
public struct BodyFatPercentage: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "body-fat-percentage", version: "1.0")
    
    /// Body fat percentage
    public var bodyFatPercentage: BodyFatPercentageUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame?
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init(
        bodyFatPercentage: BodyFatPercentageUnitValue,
        effectiveTimeFrame: TimeFrame? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bodyFatPercentage = bodyFatPercentage
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }
}
