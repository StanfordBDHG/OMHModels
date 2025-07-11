//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels
import Testing


@Suite("OMH Models Tests")
struct OMHModelsTests {
    var startDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 0) // Date Stanford University opened (https://www.stanford.edu/about/history/)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
    }
    
    var endDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 42)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
    }
    
    var timeFrame: TimeFrame {
        get throws {
            TimeFrame(timeInterval: TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate)))
        }
    }
    
    @Test("Blood Glucose")
    func testBloodGlucose() throws {
        let beforeBreakfastGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 80),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToMeal: TemporalRelationshipToMeal.beforeBreakfast
        )
        
        #expect(beforeBreakfastGlucose.bloodGlucose.value == 80)
        #expect(beforeBreakfastGlucose.temporalRelationshipToMeal == TemporalRelationshipToMeal.beforeBreakfast)
        #expect(beforeBreakfastGlucose.specimenSource == SpecimenSource.capillaryBlood)
        #expect(beforeBreakfastGlucose.effectiveTimeFrame == (try timeFrame))
        
        let duringSleepBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 70),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToSleep: TemporalRelationshipToSleep.duringSleep
        )
        
        #expect(duringSleepBloodGlucose.bloodGlucose.value == 70)
        #expect(duringSleepBloodGlucose.temporalRelationshipToSleep == TemporalRelationshipToSleep.duringSleep)
        #expect(duringSleepBloodGlucose.specimenSource == SpecimenSource.capillaryBlood)
        #expect(duringSleepBloodGlucose.effectiveTimeFrame == (try timeFrame))
        
        let averageBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 120),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: DescriptiveStatistic.average
        )
        
        #expect(averageBloodGlucose.bloodGlucose.value == 120)
        #expect(averageBloodGlucose.descriptiveStatistic == DescriptiveStatistic.average)
        #expect(averageBloodGlucose.effectiveTimeFrame == (try timeFrame))
    }
    
    @Test("Heart Rate")
    func testHeartRate() throws {
        let heartRateOnWaking = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToSleep: .onWaking
        )
        
        #expect(50 == heartRateOnWaking.heartRate.value)
        #expect(heartRateOnWaking.temporalRelationshipToSleep == TemporalRelationshipToSleep.onWaking)
        
        let heartRateWithActivity = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 120),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToPhysicalActivity: .duringExercise
        )
        
        #expect(120 == heartRateWithActivity.heartRate.value)
        #expect(heartRateWithActivity.temporalRelationshipToPhysicalActivity == .duringExercise)
        #expect(heartRateWithActivity.effectiveTimeFrame == (try timeFrame))
        
        let heartRateWithDescriptiveStatistics = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .minimum
        )
        
        #expect(50 == heartRateWithDescriptiveStatistics.heartRate.value)
        #expect(heartRateWithDescriptiveStatistics.descriptiveStatistic == .minimum)
        #expect(heartRateWithDescriptiveStatistics.effectiveTimeFrame == (try timeFrame))
    }
    
    @Test("Step Count")
    func testStepCount() throws {
        let simpleStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 5000),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(5000 == simpleStepCount.stepCount.value)
        #expect(simpleStepCount.effectiveTimeFrame == (try timeFrame))
        #expect(simpleStepCount.descriptiveStatistic == nil)
        #expect(simpleStepCount.descriptiveStatisticDenominator == nil)
        
        let averageStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 6500),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        
        #expect(6500 == averageStepCount.stepCount.value)
        #expect(averageStepCount.effectiveTimeFrame == (try timeFrame))
        #expect(averageStepCount.descriptiveStatistic == .average)
        #expect(averageStepCount.descriptiveStatisticDenominator == .d)
    }
    
    @Test("Body Weight")
    func testBodyWeight() throws {
        let simpleBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(simpleBodyWeight.bodyWeight.value == 100)
        #expect(simpleBodyWeight.bodyWeight.unit == .kg)
        #expect(simpleBodyWeight.effectiveTimeFrame == (try timeFrame))
        
        let averageBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average
        )
        
        #expect(averageBodyWeight.descriptiveStatistic == .average)
    }
    
    @Test("Body Height")
    func testBodyHeight() throws {
        let simpleBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 180),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(simpleBodyHeight.bodyHeight.value == 180)
        #expect(simpleBodyHeight.bodyHeight.unit == .cm)
        #expect(simpleBodyHeight.effectiveTimeFrame == (try timeFrame))
        
        let averageBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 200),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .maximum
        )
        
        #expect(averageBodyHeight.descriptiveStatistic == .maximum)
    }
    
    @Test("Body Temperature")
    func testBodyTemperature() throws {
        let simpleBodyTemperature = BodyTemperature(
            bodyTemperature: TemperatureUnitValue(unit: .C, value: 37),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(simpleBodyTemperature.bodyTemperature.value == 37)
        #expect(simpleBodyTemperature.bodyTemperature.unit == TemperatureUnit.C)
        #expect(simpleBodyTemperature.effectiveTimeFrame == (try timeFrame))
    }
    
    @Test("Respiratory Rate")
    func testRespiratoryRate() throws {
        let simpleRespiratoryRate = RespiratoryRate(
            respiratoryRate: RespiratoryRateUnitValue(unit: .breathsPerMinute, value: 20),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(simpleRespiratoryRate.respiratoryRate.value == 20)
        #expect(simpleRespiratoryRate.respiratoryRate.unit == RespiratoryRateUnit.breathsPerMinute)
        #expect(simpleRespiratoryRate.effectiveTimeFrame == (try timeFrame))
    }
    
    @Test("Total Sleep Time")
    func testTotalSleepTime() throws {
        let totalSleepTime = TotalSleepTime(
            totalSleepTime: DurationUnitValue(unit: .min, value: 465),
            effectiveTimeFrame: try timeFrame
        )
        
        #expect(totalSleepTime.totalSleepTime.value == 465)
        #expect(totalSleepTime.totalSleepTime.unit == .min)
    }
    
    @Test("Body Fat Percentage")
    func testBodyFatPercentage() throws {
        let bodyFatPercentage = BodyFatPercentage(
            bodyFatPercentage: BodyFatPercentageUnitValue(unit: .percent, value: 16)
        )
        
        #expect(bodyFatPercentage.bodyFatPercentage.value == 16)
        #expect(bodyFatPercentage.bodyFatPercentage.unit == .percent)
    }
    
    @Test("Body Mass Index")
    func testBodyMassIndex() throws {
        let bodyMassIndex = BodyMassIndex(
            bodyMassIndex: BodyMassIndexUnitValue(unit: .kilogramsPerMeterSquared, value: 22.5), effectiveTimeFrame: try timeFrame
        )
        
        #expect(bodyMassIndex.bodyMassIndex.value == 22.5)
        #expect(bodyMassIndex.bodyMassIndex.unit == .kilogramsPerMeterSquared)
    }
    
    @Test("Duration Unit Value")
    func testDurationUnitValue() {
        let duration1 = DurationUnitValue(
            unit: .min,
            value: 60
        )
        
        let duration2 = DurationUnitValue(
            unit: .min,
            value: 90
        )
        
        #expect(60 == duration1.value)
        #expect(90 == duration2.value)
        #expect(duration1 != duration2)
    }
    
    @Test("HealthKit Unit Value")
    func testHealthKitUnitValue() {
        let healthKitUnit = HealthKitUnitValue(unit: HealthKitUnit(unit: "count"), value: 100)
        
        #expect(healthKitUnit.value == 100)
    }
}
