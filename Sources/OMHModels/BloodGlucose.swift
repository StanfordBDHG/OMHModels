//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A Blood Glucose measurement
/// Generated from Open mHealth `omh:blood-glucose:3.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_blood-glucose)
public struct BloodGlucose: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "blood-glucose", version: "3.0")
    
    /// The blood glucose measurement as a `UnitValue` containing a double value and a unit
    public var bloodGlucose: BloodGlucoseUnitValue

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The type of specimen this measurement was made on (e.g. capillary blood)
    public var specimenSource: SpecimenSource?

    /// The relationship of this measurement to meals (e.g. before breakfast)
    public var temporalRelationshipToMeal: TemporalRelationshipToMeal?

    /// The relationship of this measurement to sleep (e.g. on waking)
    public var temporalRelationshipToSleep: TemporalRelationshipToSleep?

    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init (
        bloodGlucose: BloodGlucoseUnitValue,
        effectiveTimeFrame: TimeFrame,
        specimenSource: SpecimenSource? = nil,
        temporalRelationshipToMeal: TemporalRelationshipToMeal? = nil,
        temporalRelationshipToSleep: TemporalRelationshipToSleep? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bloodGlucose = bloodGlucose
        self.effectiveTimeFrame = effectiveTimeFrame
        self.specimenSource = specimenSource
        self.temporalRelationshipToMeal = temporalRelationshipToMeal
        self.temporalRelationshipToSleep = temporalRelationshipToSleep
        self.descriptiveStatistic = descriptiveStatistic
    }
}
