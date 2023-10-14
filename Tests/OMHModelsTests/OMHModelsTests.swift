//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class OMHModelsTests: XCTestCase {
    var startDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 0) // Date Stanford University opened (https://www.stanford.edu/about/history/)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    var endDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 42)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    var timeFrame: TimeFrame {
        get throws {
            TimeFrame(timeInterval: TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate)))
        }
    }
    
    func testBloodGlucose() throws {
        let beforeBreakfastGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 80),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToMeal: TemporalRelationshipToMeal.beforeBreakfast
        )
        
        XCTAssertEqual(beforeBreakfastGlucose.bloodGlucose.value, 80)
        XCTAssertEqual(beforeBreakfastGlucose.temporalRelationshipToMeal, TemporalRelationshipToMeal.beforeBreakfast)
        XCTAssertEqual(beforeBreakfastGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(beforeBreakfastGlucose.effectiveTimeFrame, try timeFrame)
        
        let duringSleepBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 70),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToSleep: TemporalRelationshipToSleep.duringSleep
        )
        
        XCTAssertEqual(duringSleepBloodGlucose.bloodGlucose.value, 70)
        XCTAssertEqual(duringSleepBloodGlucose.temporalRelationshipToSleep, TemporalRelationshipToSleep.duringSleep)
        XCTAssertEqual(duringSleepBloodGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(duringSleepBloodGlucose.effectiveTimeFrame, try timeFrame)
        
        let averageBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 120),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: DescriptiveStatistic.average
        )
        
        XCTAssertEqual(averageBloodGlucose.bloodGlucose.value, 120)
        XCTAssertEqual(averageBloodGlucose.descriptiveStatistic, DescriptiveStatistic.average)
        XCTAssertEqual(averageBloodGlucose.effectiveTimeFrame, try timeFrame)
    }
    
    func testHeartRate() throws {
        let heartRateOnWaking = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToSleep: .onWaking
        )
        
        XCTAssertEqual(50, heartRateOnWaking.heartRate.value)
        XCTAssertEqual(heartRateOnWaking.temporalRelationshipToSleep, TemporalRelationshipToSleep.onWaking)
        
        let heartRateWithActivity = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 120),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToPhysicalActivity: .duringExercise
        )
        
        XCTAssertEqual(120, heartRateWithActivity.heartRate.value)
        XCTAssertEqual(heartRateWithActivity.temporalRelationshipToPhysicalActivity, .duringExercise)
        XCTAssertEqual(heartRateWithActivity.effectiveTimeFrame, try timeFrame)
        
        let heartRateWithDescriptiveStatistics = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .minimum
        )
        
        XCTAssertEqual(50, heartRateWithDescriptiveStatistics.heartRate.value)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.descriptiveStatistic, .minimum)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.effectiveTimeFrame, try timeFrame)
    }
    
    func testStepCount() throws {
        let simpleStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 5000),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(5000, simpleStepCount.stepCount.value)
        XCTAssertEqual(simpleStepCount.effectiveTimeFrame, try timeFrame)
        XCTAssertNil(simpleStepCount.descriptiveStatistic)
        XCTAssertNil(simpleStepCount.descriptiveStatisticDenominator)
        
        let averageStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 6500),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        
        XCTAssertEqual(6500, averageStepCount.stepCount.value)
        XCTAssertEqual(averageStepCount.effectiveTimeFrame, try timeFrame)
        XCTAssertEqual(averageStepCount.descriptiveStatistic, .average)
        XCTAssertEqual(averageStepCount.descriptiveStatisticDenominator, .d)
    }
    
    func testBodyWeight() throws {
        let simpleBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleBodyWeight.bodyWeight.value, 100)
        XCTAssertEqual(simpleBodyWeight.bodyWeight.unit, .kg)
        XCTAssertEqual(simpleBodyWeight.effectiveTimeFrame, try timeFrame)
        
        let averageBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average
        )
        
        XCTAssertEqual(averageBodyWeight.descriptiveStatistic, .average)
    }
    
    func testBodyHeight() throws {
        let simpleBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 180),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleBodyHeight.bodyHeight.value, 180)
        XCTAssertEqual(simpleBodyHeight.bodyHeight.unit, .cm)
        XCTAssertEqual(simpleBodyHeight.effectiveTimeFrame, try timeFrame)
        
        let averageBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 200),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .maximum
        )
        
        XCTAssertEqual(averageBodyHeight.descriptiveStatistic, .maximum)
    }
    
    func testBodyTemperature() throws {
        let simpleBodyTemperature = BodyTemperature(
            bodyTemperature: TemperatureUnitValue(unit: .C, value: 37),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleBodyTemperature.bodyTemperature.value, 37)
        XCTAssertEqual(simpleBodyTemperature.bodyTemperature.unit, TemperatureUnit.C)
        XCTAssertEqual(simpleBodyTemperature.effectiveTimeFrame, try timeFrame)
    }
    
    func testRespiratoryRate() throws {
        let simpleRespiratoryRate = RespiratoryRate(
            respiratoryRate: RespiratoryRateUnitValue(unit: .breathsPerMinute, value: 20),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleRespiratoryRate.respiratoryRate.value, 20)
        XCTAssertEqual(simpleRespiratoryRate.respiratoryRate.unit, RespiratoryRateUnit.breathsPerMinute)
        XCTAssertEqual(simpleRespiratoryRate.effectiveTimeFrame, try timeFrame)
    }
    
    func testTotalSleepTime() throws {
        let totalSleepTime = TotalSleepTime(
            totalSleepTime: DurationUnitValue(unit: .min, value: 465),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(totalSleepTime.totalSleepTime.value, 465)
        XCTAssertEqual(totalSleepTime.totalSleepTime.unit, .min)
    }
    
    func testBodyFatPercentage() throws {
        let bodyFatPercentage = BodyFatPercentage(
            bodyFatPercentage: BodyFatPercentageUnitValue(unit: .percent, value: 16)
        )
        
        XCTAssertEqual(bodyFatPercentage.bodyFatPercentage.value, 16)
        XCTAssertEqual(bodyFatPercentage.bodyFatPercentage.unit, .percent)
    }
    
    func testBodyMassIndex() throws {
        let bodyMassIndex = BodyMassIndex(
            bodyMassIndex: BodyMassIndexUnitValue(unit: .kilogramsPerMeterSquared, value: 22.5), effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(bodyMassIndex.bodyMassIndex.value, 22.5)
        XCTAssertEqual(bodyMassIndex.bodyMassIndex.unit, .kilogramsPerMeterSquared)
    }
    
    func testDurationUnitValue() {
        let duration1 = DurationUnitValue(
            unit: .min,
            value: 60
        )
        
        let duration2 = DurationUnitValue(
            unit: .min,
            value: 90
        )
        
        XCTAssertEqual(60, duration1.value)
        XCTAssertEqual(90, duration2.value)
        XCTAssertNotEqual(duration1, duration2)
    }
    
    func testHealthKitUnitValue() {
        let healthKitUnit = HealthKitUnitValue(unit: HealthKitUnit(unit: "count"), value: 100)
        
        XCTAssertEqual(healthKitUnit.value, 100)
    }
}
