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


/// Decodes the sample data published in the IEEE 1752 repository (https://opensource.ieee.org/omh/1752/-/tree/main/sample_data)
/// and checks that encoding the decoded value again doesn't lose any information.
@Suite("IEEE 1752 Sample Data Tests")
struct IEEE1752SampleDataTests {
    private static let sampleDataDirectory = Bundle.module.url(forResource: "IEEE1752", withExtension: nil)

    /// Properties in the sample data that aren't defined by the schemas and therefore aren't decoded:
    /// the sample data documents each example in a `description`, and some sleep stage summary samples use names
    /// that differ from the `sleep-stage-summary` schema (`awake_duration`, `awake_percentage`, `sleep_efficiency_percentage`).
    private static let undefinedProperties: Set<String> = [
        "description",
        "awake_sleep_duration",
        "awake_sleep_percentage",
        "total_sleep_efficiency_percentage"
    ]

    static let sampleFiles: [String] = {
        guard let sampleDataDirectory,
              let enumerator = FileManager.default.enumerator(at: sampleDataDirectory, includingPropertiesForKeys: nil) else {
            return []
        }
        return enumerator
            .compactMap { $0 as? URL }
            .filter { $0.pathExtension == "json" }
            // Resolve symbolic links (e.g., /tmp and /private/tmp) on both sides before computing the relative path.
            .map { $0.resolvingSymlinksInPath().path.replacingOccurrences(of: sampleDataDirectory.resolvingSymlinksInPath().path + "/", with: "") }
            .sorted()
    }()


    private static func roundTrip(file: String) -> ((Data) throws -> Data)? {
        let name = (file as NSString).lastPathComponent
        let prefixes: [(String, (Data) throws -> Data)] = [
            ("header-", roundTrip(Header.self)),
            ("schema-id-", roundTrip(SchemaId.self)),
            ("data-point-sample-data-phys-activity", roundTrip(SchemaDataPoint<PhysicalActivity>.self)),
            ("data-point-sample-data-ambient-temp", roundTrip(SchemaDataPoint<AmbientTemperature>.self)),
            ("data-series-sample-series-ambient-temp", roundTrip(SchemaDataSeries<AmbientTemperature>.self)),
            ("ambient-light-", roundTrip(AmbientLight.self)),
            ("ambient-sound-", roundTrip(AmbientSound.self)),
            ("ambient-temperature-", roundTrip(AmbientTemperature.self)),
            ("apnea-hypopnea-index-", roundTrip(ApneaHypopneaIndex.self)),
            ("arousal-index-", roundTrip(ArousalIndex.self)),
            ("deep-sleep-", roundTrip(DeepSleep.self)),
            ("light-sleep-", roundTrip(LightSleep.self)),
            ("sleep-episode-", roundTrip(SleepEpisode.self)),
            ("sleep-onset-latency-", roundTrip(SleepOnsetLatency.self)),
            ("sleep-stage-summary-", roundTrip(SleepStageSummary.self)),
            ("snore-index-", roundTrip(SnoreIndex.self)),
            ("time-in-bed-", roundTrip(TimeInBed.self)),
            ("wake-after-sleep-onset-", roundTrip(WakeAfterSleepOnset.self)),
            ("illuminance-unit-value-", roundTrip(IlluminanceUnitValue.self)),
            ("percent-unit-value-", roundTrip(PercentUnitValue.self)),
            ("sound-unit-value-", roundTrip(SoundUnitValue.self)),
            ("physical-activity-", roundTrip(PhysicalActivity.self)),
            ("example-", roundTrip(Survey.self)),
            ("body-posture-", roundTrip(BodyPosture.self)),
            ("date-time-", roundTrip(DateTime.self)),
            ("descriptive-statistic-denominator-", roundTrip(DescriptiveStatisticDenominator.self)),
            ("descriptive-statistic-", roundTrip(DescriptiveStatistic.self)),
            ("duration-unit-value-range-", roundTrip(DurationUnitValueRange.self)),
            ("duration-unit-value-", roundTrip(DurationUnitValue.self)),
            ("frequency-unit-value-", roundTrip(FrequencyUnitValue.self)),
            ("kcal-unit-value-", roundTrip(KcalUnitValue.self)),
            ("length-unit-value-", roundTrip(LengthUnitValue.self)),
            ("speed-unit-value-", roundTrip(SpeedUnitValue.self)),
            ("temperature-unit-value-", roundTrip(TemperatureUnitValue.self)),
            ("time-frame-", roundTrip(TimeFrame.self)),
            ("time-interval-", roundTrip(OMHModels.TimeInterval.self)),
            ("unit-value-range-", roundTrip(TypedUnitValueRange<HealthKitUnit>.self)),
            ("unit-value-", roundTrip(TypedUnitValue<HealthKitUnit>.self)),
            ("total-sleep-time-", roundTrip(TotalSleepTime.self))
        ]
        return prefixes.first { name.hasPrefix($0.0) }?.1
    }

    private static func roundTrip<T: Codable & Equatable>(_ type: T.Type) -> (Data) throws -> Data {
        { data in
            let decoded = try SchemaCoders.decoder.decode(T.self, from: data)
            let encoded = try SchemaCoders.encoder.encode(decoded)
            #expect(try SchemaCoders.decoder.decode(T.self, from: encoded) == decoded)
            // Decoders that still use the key coding strategy recommended by earlier versions get the same result.
            let strategyDecoder = JSONDecoder()
            strategyDecoder.keyDecodingStrategy = .convertFromSnakeCase
            #expect(try strategyDecoder.decode(T.self, from: data) == decoded)
            return encoded
        }
    }

    private static func removingUndefinedProperties(_ value: JSONValue) -> JSONValue {
        switch value {
        case .object(let object):
            .object(object.filter { !undefinedProperties.contains($0.key) }.mapValues(removingUndefinedProperties))
        case .array(let array):
            .array(array.map(removingUndefinedProperties))
        default:
            value
        }
    }


    @Test("Sample data is bundled")
    func sampleDataIsBundled() {
        #expect(!Self.sampleFiles.isEmpty)
    }

    @Test("Sample data round trip", arguments: sampleFiles)
    func sampleDataRoundTrip(file: String) throws {
        let directory = try #require(Self.sampleDataDirectory)
        let data = try Data(contentsOf: directory.appending(path: file))
        let roundTrip = try #require(Self.roundTrip(file: file), "No schema registered for \(file)")
        let reencoded = try roundTrip(data)

        let original = Self.removingUndefinedProperties(try JSONDecoder().decode(JSONValue.self, from: data))
        #expect(try JSONDecoder().decode(JSONValue.self, from: reencoded) == original)
    }
}
