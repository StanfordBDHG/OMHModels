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
            return encoded
        }
    }

    /// The sample data documents each example in a `description` property that isn't part of the schemas.
    private static func removingDescriptions(_ value: JSONValue) -> JSONValue {
        switch value {
        case .object(let object):
            .object(object.filter { $0.key != "description" }.mapValues(removingDescriptions))
        case .array(let array):
            .array(array.map(removingDescriptions))
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

        let original = Self.removingDescriptions(try JSONDecoder().decode(JSONValue.self, from: data))
        #expect(try JSONDecoder().decode(JSONValue.self, from: reencoded) == original)
    }

    /// Version 0.2.0 required key coding strategies, and these schemas decoded with `convertFromSnakeCase`.
    /// Decoders that still set the strategy must keep decoding them.
    @Test("Sample data decodes with the convertFromSnakeCase strategy", arguments: sampleFiles.filter { file in
        ["survey/", "utility/time-interval-", "utility/duration-unit-value-range-", "utility/unit-value-range-", "metadata/header-"]
            .contains { file.hasPrefix($0) }
    })
    func sampleDataWithKeyStrategy(file: String) throws {
        let directory = try #require(Self.sampleDataDirectory)
        let data = try Data(contentsOf: directory.appending(path: file))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let plainDecoder = JSONDecoder()

        if file.hasPrefix("survey/") {
            #expect(try decoder.decode(Survey.self, from: data) == plainDecoder.decode(Survey.self, from: data))
        } else if file.hasPrefix("utility/time-interval-") {
            let timeInterval = try decoder.decode(OMHModels.TimeInterval.self, from: data)
            #expect(try timeInterval == plainDecoder.decode(OMHModels.TimeInterval.self, from: data))
        } else if file.hasPrefix("metadata/header-") {
            #expect(try decoder.decode(Header.self, from: data) == plainDecoder.decode(Header.self, from: data))
        } else {
            let range = try decoder.decode(TypedUnitValueRange<HealthKitUnit>.self, from: data)
            #expect(try range == plainDecoder.decode(TypedUnitValueRange<HealthKitUnit>.self, from: data))
        }
    }
}
