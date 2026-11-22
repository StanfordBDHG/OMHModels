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


/// Decodes JSON encoded by OMHModels 0.2.0, both with a default `JSONEncoder` (camelCase keys) and with the
/// `convertToSnakeCase` key encoding strategy the 0.2.0 README recommended, using decoders with and without the
/// `convertFromSnakeCase` strategy. All four must decode to the same value, and encoding that value must produce
/// the snake case JSON of 0.2.0 apart from intentional fixes.
@Suite("0.2.0 Compatibility Tests")
struct Version020CompatibilityTests {
    private static let directory = Bundle.module.url(forResource: "Version020", withExtension: nil)

    static let fixtures: [String] = {
        guard let directory, let files = try? FileManager.default.contentsOfDirectory(atPath: directory.path) else {
            return []
        }
        return Set(files.filter { $0.hasSuffix(".default.json") }.map { $0.replacingOccurrences(of: ".default.json", with: "") }).sorted()
    }()


    @available(*, deprecated, message: "Tests deprecated types")
    private static func check(_ fixture: String) throws { // swiftlint:disable:this cyclomatic_complexity
        switch fixture {
        case "BloodGlucose": try check(BloodGlucose.self, fixture)
        case "BloodPressure": try check(BloodPressure.self, fixture)
        case "BodyFatPercentage": try check(BodyFatPercentage.self, fixture)
        case "BodyHeight": try check(BodyHeight.self, fixture)
        case "BodyMassIndex": try check(BodyMassIndex.self, fixture)
        case "BodyTemperature": try check(BodyTemperature.self, fixture)
        case "BodyWeight": try check(BodyWeight.self, fixture)
        case "HeartRate": try check(HeartRate.self, fixture)
        case "OxygenSaturation": try check(OxygenSaturation.self, fixture)
        case "RespiratoryRate": try check(RespiratoryRate.self, fixture)
        case "StepCount": try check(StepCount.self, fixture)
        case "TotalSleepTime": try check(TotalSleepTime.self, fixture)
        case "PhysicalActivity": try check(PhysicalActivity.self, fixture)
        case "HealthKitQuantitySample": try check(HealthKitQuantitySample.self, fixture)
        case "Header", "HeaderMinimal": try check(Header.self, fixture)
        case "Survey": try check(Survey.self, fixture)
        case "TimeIntervalStartDuration", "TimeIntervalEndDuration", "TimeIntervalDatePartOfDay": try check(OMHModels.TimeInterval.self, fixture)
        case "DurationUnitValueRange": try check(DurationUnitValueRange.self, fixture)
        case "AcquisitionProvenance": try check(AcquisitionProvenance.self, fixture)
        default: Issue.record("No schema registered for \(fixture)")
        }
    }

    private static func check<T: Codable & Equatable>(_ type: T.Type, _ fixture: String) throws {
        let directory = try #require(Self.directory)
        let camelCaseJSON = try Data(contentsOf: directory.appending(path: "\(fixture).default.json"))
        let snakeCaseJSON = try Data(contentsOf: directory.appending(path: "\(fixture).snake.json"))
        let plainDecoder = JSONDecoder()
        let strategyDecoder = JSONDecoder()
        strategyDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let decoded = try plainDecoder.decode(T.self, from: snakeCaseJSON)
        #expect(try plainDecoder.decode(T.self, from: camelCaseJSON) == decoded)
        #expect(try strategyDecoder.decode(T.self, from: snakeCaseJSON) == decoded)
        #expect(try strategyDecoder.decode(T.self, from: camelCaseJSON) == decoded)

        let reencoded = try JSONDecoder().decode(JSONValue.self, from: JSONEncoder().encode(decoded))
        #expect(reencoded == expectedEncoding(fixture, try JSONDecoder().decode(JSONValue.self, from: snakeCaseJSON)))
    }

    /// The snake case JSON of 0.2.0 with the intentional encoding fixes applied.
    private static func expectedEncoding(_ fixture: String, _ json: JSONValue) -> JSONValue {
        // 0.2.0 encoded HealthKit units as a nested `{"unit": "..."}` object instead of a string.
        guard fixture == "HealthKitQuantitySample",
              case var .object(sample) = json,
              case var .object(unitValue) = sample["unit_value"],
              case let .object(unit) = unitValue["unit"],
              let unitString = unit["unit"] else {
            return json
        }
        unitValue["unit"] = unitString
        sample["unit_value"] = .object(unitValue)
        return .object(sample)
    }


    @Test("0.2.0 fixtures are bundled")
    func fixturesAreBundled() {
        #expect(Self.fixtures.count >= 20)
    }

    @Test("JSON encoded by 0.2.0 decodes", arguments: fixtures)
    @available(*, deprecated, message: "Tests deprecated types")
    func decodesVersion020JSON(fixture: String) throws {
        try Self.check(fixture)
    }
}
