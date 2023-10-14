//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

@testable import OMHModels
import XCTest

class PhysicalActivityTests: XCTestCase {
    func testPhysicalActivity() {
        // Create mock values
        let mockBaseMovementQuantity = TypedUnitValue<BaseMovementQuantityUnit>(unit: .steps, value: 100)
        let mockTimeFrame = TimeFrame(
            timeInterval: TimeInterval(
                startDateTime: DateTime(date: .now),
                duration: DurationUnitValue(
                    unit: TimeUnit.h,
                    value: 1.0
                )
            )
        )
        let mockDistance = LengthUnitValue(unit: .m, value: 5.0)
        let mockKcalBurned = KcalUnitValue(unit: .kcal, value: 500)
        let mockDescriptiveStatistic = DescriptiveStatistic.average
        let mockDescriptiveStatisticDenominator = DescriptiveStatisticDenominator.d
        
        // Initialize the PhysicalActivity struct
        let activity = PhysicalActivity(
            activityName: "Walking",
            baseMovementQuantity: mockBaseMovementQuantity,
            effectiveTimeFrame: mockTimeFrame,
            distance: mockDistance,
            kcalBurned: mockKcalBurned,
            reportedActivityIntensity: .light,
            metValue: 3.5,
            descriptiveStatistic: mockDescriptiveStatistic,
            descriptiveStatisticDenominator: mockDescriptiveStatisticDenominator
        )
        
        XCTAssertEqual(activity.activityName, "Walking")
        XCTAssertEqual(activity.baseMovementQuantity, mockBaseMovementQuantity)
        XCTAssertEqual(activity.effectiveTimeFrame, mockTimeFrame)
        XCTAssertEqual(activity.distance, mockDistance)
        XCTAssertEqual(activity.kcalBurned, mockKcalBurned)
        XCTAssertEqual(activity.reportedActivityIntensity, .light)
        XCTAssertEqual(activity.metValue, 3.5)
        XCTAssertEqual(activity.descriptiveStatistic, mockDescriptiveStatistic)
        XCTAssertEqual(activity.descriptiveStatisticDenominator, mockDescriptiveStatisticDenominator)
    }
}
