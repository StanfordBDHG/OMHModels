//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels
import Testing


/// Creates the IEEE 1752 environment and sleep schemas with every property set and checks that they keep every value
/// through their initializers and a JSON round trip.
@Suite("IEEE 1752 Initializer Tests")
struct IEEE1752InitializerTests {
    private let interval = TimeFrame(
        timeInterval: OMHModels.TimeInterval(
            startDateTime: DateTime(date: Date(timeIntervalSince1970: 1_700_000_000)),
            endDateTime: DateTime(date: Date(timeIntervalSince1970: 1_700_028_800))
        )
    )
    private let hours = DurationUnitValue(unit: .h, value: 8)
    private let minutes = DurationUnitValue(unit: .min, value: 15)
    private let percent = PercentUnitValue(unit: .percent, value: 25)


    private func roundTrip<T: Codable & Equatable>(_ value: T) throws {
        let data = try JSONEncoder().encode(value)
        #expect(try JSONDecoder().decode(T.self, from: data) == value)
    }


    @Test("Environment schemas")
    func environment() throws {
        let light = AmbientLight(
            ambientLight: [
                AmbientLightMeasurement(
                    intensity: IlluminanceUnitValue(unit: .lx, value: 300),
                    wavelength: WavelengthUnitValue(unit: .nm, value: 550)
                )
            ],
            effectiveTimeFrame: interval,
            descriptiveStatistic: .average
        )
        #expect(light.ambientLight.first?.wavelength?.value == 550)
        #expect(light.descriptiveStatistic == .average)
        try roundTrip(light)

        let sound = AmbientSound(ambientSound: SoundUnitValue(unit: .dBA, value: 40), effectiveTimeFrame: interval, descriptiveStatistic: .maximum)
        #expect(sound.ambientSound.unit == .dBA)
        try roundTrip(sound)

        let temperature = AmbientTemperature(
            ambientTemperature: TemperatureUnitValue(unit: .C, value: 21),
            effectiveTimeFrame: interval,
            descriptiveStatistic: .minimum
        )
        #expect(temperature.descriptiveStatistic == .minimum)
        try roundTrip(temperature)
    }

    @Test("Sleep index schemas")
    func sleepIndices() throws {
        let apneaHypopnea = ApneaHypopneaIndex(
            apneaHypopneaIndex: ApneaHypopneaIndexUnitValue(unit: .eventsPerHour, value: 4),
            effectiveTimeFrame: interval,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        #expect(apneaHypopnea.descriptiveStatisticDenominator == .d)
        try roundTrip(apneaHypopnea)

        let arousal = ArousalIndex(
            arousalIndex: ArousalIndexUnitValue(unit: .awakeningsPerHour, value: 2),
            effectiveTimeFrame: interval,
            isMainSleep: true,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: "night"
        )
        #expect(arousal.isMainSleep == true)
        #expect(arousal.descriptiveStatisticDenominator?.rawValue == "night")
        try roundTrip(arousal)

        let snore = SnoreIndex(
            snoreIndex: SnoreIndexUnitValue(unit: .snoresPerHour, value: 12),
            effectiveTimeFrame: interval,
            snoreEvents: [
                SnoreEvent(
                    snored: true,
                    snoreTimeFrame: OMHModels.TimeInterval(
                        startDateTime: DateTime(date: Date(timeIntervalSince1970: 1_700_000_000)),
                        duration: minutes
                    ),
                    snoreIntensity: SoundUnitValue(unit: .dB, value: 50),
                    bodyPosture: .lyingDown
                )
            ],
            isMainSleep: true,
            descriptiveStatistic: .count,
            descriptiveStatisticDenominator: .episode
        )
        #expect(snore.snoreEvents.first?.bodyPosture == .lyingDown)
        try roundTrip(snore)
    }

    @Test("Sleep duration schemas")
    func sleepDurations() throws {
        let deep = DeepSleep(
            deepSleepDuration: minutes,
            totalSleepTime: hours,
            effectiveTimeFrame: interval,
            deepSleepPercentage: percent,
            isMainSleep: true,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .wk
        )
        #expect(deep.deepSleepPercentage == percent)
        try roundTrip(deep)

        let light = LightSleep(
            lightSleepDuration: minutes,
            totalSleepTime: hours,
            effectiveTimeFrame: interval,
            lightSleepPercentage: percent,
            isMainSleep: false,
            descriptiveStatistic: .median,
            descriptiveStatisticDenominator: .Mo
        )
        #expect(light.isMainSleep == false)
        try roundTrip(light)

        let onset = SleepOnsetLatency(
            sleepOnsetLatency: minutes,
            effectiveTimeFrame: interval,
            isMainSleep: true,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        #expect(onset.sleepOnsetLatency == minutes)
        try roundTrip(onset)

        let inBed = TimeInBed(
            timeInBed: hours,
            effectiveTimeFrame: interval,
            isMainSleep: true,
            descriptiveStatistic: .sum,
            descriptiveStatisticDenominator: .wk
        )
        #expect(inBed.timeInBed == hours)
        try roundTrip(inBed)

        let wake = WakeAfterSleepOnset(
            wakeAfterSleepOnset: minutes,
            effectiveTimeFrame: interval,
            awakeningDurations: [minutes, minutes],
            descriptiveStatistic: .sum,
            descriptiveStatisticDenominator: .d
        )
        #expect(wake.awakeningDurations.count == 2)
        try roundTrip(wake)
    }

    @Test("Sleep episode and sleep stage summary")
    func sleepEpisodeAndSummary() throws {
        let episode = SleepEpisode(
            effectiveTimeFrame: interval,
            latencyToSleepOnset: minutes,
            latencyToArising: minutes,
            totalSleepTime: hours,
            lightSleepDuration: hours,
            deepSleepDuration: minutes,
            remSleepDuration: minutes,
            wakeAfterSleepOnset: minutes,
            numberOfAwakenings: 3,
            isMainSleep: true,
            sleepEfficiencyPercentage: percent
        )
        #expect(episode.numberOfAwakenings == 3)
        #expect(episode.sleepEfficiencyPercentage == percent)
        try roundTrip(episode)

        let details = SleepStageSummaryDetails(
            totalSleepTime: hours,
            sleepEfficiencyPercentage: percent,
            latencyToSleepOnset: minutes,
            latencyToArising: minutes,
            remSleepDuration: minutes,
            remSleepEpisodeCount: 4,
            remSleepPercentage: percent,
            lightSleepDuration: hours,
            lightSleepEpisodeCount: 5,
            lightSleepPercentage: percent,
            deepSleepDuration: minutes,
            deepSleepEpisodeCount: 2,
            deepSleepPercentage: percent,
            awakeDuration: minutes,
            numberOfAwakenings: 3,
            awakePercentage: percent,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        let summary = SleepStageSummary(
            sleepStageSummary: details,
            effectiveTimeFrame: interval,
            sleepStageEpisodes: [SleepStageEpisode(sleepStageState: .rem, sleepStageTimeFrame: interval)],
            isMainSleep: true
        )
        #expect(summary.sleepStageSummary.deepSleepEpisodeCount == 2)
        #expect(summary.sleepStageEpisodes.first?.sleepStageState == .rem)
        try roundTrip(summary)
    }

    @Test("Data series use the body's schema ID")
    func dataSeries() throws {
        let body = [AmbientTemperature(ambientTemperature: TemperatureUnitValue(unit: .C, value: 21), effectiveTimeFrame: interval)]
        let series = SchemaDataSeries(body: body, modality: .sensed)
        #expect(series.header.schemaId == AmbientTemperature.schemaId)
        #expect(series.header.modality == .sensed)
        try roundTrip(series)

        let explicit = SchemaDataSeries(header: series.header, body: body)
        #expect(explicit == series)
    }

    @Test("Physical activity units accept other values")
    func physicalActivityUnits() throws {
        let pushes: BaseMovementQuantityUnit = "pushes"
        #expect(BaseMovementQuantityUnit(rawValue: "pushes") == pushes)
        let cadence: AverageCadenceUnit = "pushes/min"
        #expect(AverageCadenceUnit(rawValue: "pushes/min") == cadence)
        try roundTrip(AverageCadenceUnitValue(unit: cadence, value: 30))
    }
}
