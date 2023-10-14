//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

/// A unit value that represents the number of repetitions of the activity base movement and the associated unit
public typealias BaseMovementQuantityUnitValue = TypedUnitValue<BaseMovementQuantityUnit>

/// Units for representing base movement
public enum BaseMovementQuantityUnit: String, UnitProtocol {
    case steps
    case laps
    case skips
    case movements
    case strokes
}

/// A unit value that represents the average rate at which the activity was performed and the associated unit
public typealias AverageCadenceUnitValue = TypedUnitValue<AverageCadenceUnit>

/// Units for representing the average rate at which activity was performed
public enum AverageCadenceUnit: String, UnitProtocol {
    case stepsPerMin = "steps/min"
    case strokesPerMin = "strokes/min"
    case skipsPerMin = "skips/min"
    case lapsPerMin = "laps/min"
    case movementsPerMin = "movements/min"
    case strokesPerLap = "strokes/lap"
}

public enum ReportedActivityIntensity: String, Codable, Sendable {
    case light
    case moderate
    case vigorous
}


/// Episode(s) of physical activity
/// Generated from IEEE 1752.1 `physical-activity-1.0` (https://w3id.org/ieee/ieee-1752-schema/physical-activity.json)
public struct PhysicalActivity: Schema {
    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "physical-activity", version: "1.0")
    
    /// The name of the physical activity in which the person is engaged. This can be sedentary. It is recommended that the activity name be drawn from the latest CDC guidelines to facilitate mapping to standard energy expenditure values (METs) or other peer-reviewed source.
    public var activityName: String
    
    /// Number of repetitions of the activity base movement, if applicable
    public var baseMovementQuantity: BaseMovementQuantityUnitValue?
    
    /// The date-time at which, or time interval during which the measurement is asserted as being valid. As a measure of a duration, physical activity should not be associated to a date-time time frame. Hence, effective time frame is restricted to be a time interval.
    public var effectiveTimeFrame: TimeFrame
    
    /// The distance covered, if applicable.
    public var distance: LengthUnitValue?
    
    /// The total ascent, if applicable.
    public var cumulativeElevationGain: LengthUnitValue?
    
    /// The net duration of the activity.
    public var duration: DurationUnitValue?
    
    /// The duration of light-intensity physical activity.
    public var durationLightActivity: DurationUnitValue?
    
    /// The duration of moderate-intensity physical activity.
    public var durationModerateActivity: DurationUnitValue?
    
    /// The duration of vigorous-intensity physical activity.
    public var durationVigorousActivity: DurationUnitValue?
    
    /// The average rate at which the activity was performed, if applicable. If none of the units listed applies, the string alternative will allow validation of the unlisted unit.
    public var averageCadence: AverageCadenceUnitValue?
    
    /// The average speed at which the activity was performed, if applicable.
    public var averageSpeed: SpeedUnitValue?
    
    /// The calories burned during the activity.
    public var kcalBurned: KcalUnitValue?
    
    /// Self-reported intensity of the activity performed.
    public var reportedActivityIntensity: ReportedActivityIntensity?
    
    /// Average Metabolic Equivalent of Task value for the activity. MET is defined as 3.5 mL\u00b7kg^\u22121\u00b7min^\u22121, often characterized as the metabolic cost of resting quietly.
    public var metValue: Double?
    
    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame.
    public var descriptiveStatistic: DescriptiveStatistic?
    
    /// The denominator of the descriptive statistic when the measure has an implicit duration (e.g., if activity is 'walking', the descriptive statistic is 'average' and the statistic denominator is 'd' the measure describes the average daily measure of walking during the period delimited by the effective time frame).
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?
    
    // swiftlint:disable function_default_parameter_at_end
    // We disable this rule because the parameter order is based on the schema.
    public init(
        activityName: String,
        baseMovementQuantity: BaseMovementQuantityUnitValue? = nil,
        effectiveTimeFrame: TimeFrame,
        distance: LengthUnitValue? = nil,
        cumulativeElevationGain: LengthUnitValue? = nil,
        duration: DurationUnitValue? = nil,
        durationLightActivity: DurationUnitValue? = nil,
        durationModerateActivity: DurationUnitValue? = nil,
        durationVigorousActivity: DurationUnitValue? = nil,
        averageCadence: AverageCadenceUnitValue? = nil,
        averageSpeed: SpeedUnitValue? = nil,
        kcalBurned: KcalUnitValue? = nil,
        reportedActivityIntensity: ReportedActivityIntensity? = nil,
        metValue: Double? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.activityName = activityName
        self.baseMovementQuantity = baseMovementQuantity
        self.effectiveTimeFrame = effectiveTimeFrame
        self.distance = distance
        self.cumulativeElevationGain = cumulativeElevationGain
        self.duration = duration
        self.durationLightActivity = durationLightActivity
        self.durationModerateActivity = durationModerateActivity
        self.durationVigorousActivity = durationVigorousActivity
        self.averageCadence = averageCadence
        self.averageSpeed = averageSpeed
        self.kcalBurned = kcalBurned
        self.reportedActivityIntensity = reportedActivityIntensity
        self.metValue = metValue
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }
}
