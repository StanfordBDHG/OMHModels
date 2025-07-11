//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation
@testable import OMHModels
import Testing

@Suite("Physical Activity Tests")
struct PhysicalActivityTests {
    @Test("Physical Activity")
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
        
        #expect(activity.activityName == "Walking")
        #expect(activity.baseMovementQuantity == mockBaseMovementQuantity)
        #expect(activity.effectiveTimeFrame == mockTimeFrame)
        #expect(activity.distance == mockDistance)
        #expect(activity.kcalBurned == mockKcalBurned)
        #expect(activity.reportedActivityIntensity == .light)
        #expect(activity.metValue == 3.5)
        #expect(activity.descriptiveStatistic == mockDescriptiveStatistic)
        #expect(activity.descriptiveStatisticDenominator == mockDescriptiveStatisticDenominator)
    }
}
