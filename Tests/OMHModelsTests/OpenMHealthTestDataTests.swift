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


/// Decodes the valid (`shouldPass`) Open mHealth test data (https://github.com/openmhealth/schemas/tree/main/test-data/omh)
/// and checks that encoding the decoded value again doesn't lose any information.
@Suite("Open mHealth Test Data Tests")
struct OpenMHealthTestDataTests {
    private static let testDataDirectory = Bundle.module.url(forResource: "OpenMHealth", withExtension: nil)

    static let testFiles: [String] = {
        guard let testDataDirectory,
              let enumerator = FileManager.default.enumerator(at: testDataDirectory, includingPropertiesForKeys: nil) else {
            return []
        }
        return enumerator
            .compactMap { $0 as? URL }
            .filter { $0.pathExtension == "json" }
            // Resolve symbolic links (e.g., /tmp and /private/tmp) on both sides before computing the relative path.
            .map { $0.resolvingSymlinksInPath().path.replacingOccurrences(of: testDataDirectory.resolvingSymlinksInPath().path + "/", with: "") }
            .sorted()
    }()


    // swiftlint:disable:next cyclomatic_complexity
    private static func roundTrip(schema: String) -> ((Data) throws -> Data)? {
        switch schema {
        case "blood-glucose": roundTrip(BloodGlucose.self)
        case "blood-pressure": roundTrip(BloodPressure.self)
        case "body-fat-percentage": roundTrip(BodyFatPercentage.self)
        case "body-height": roundTrip(BodyHeight.self)
        case "body-mass-index": roundTrip(BodyMassIndex.self)
        case "body-temperature": roundTrip(BodyTemperature.self)
        case "body-weight": roundTrip(BodyWeight.self)
        case "geoposition": roundTrip(Geoposition.self)
        case "heart-rate": roundTrip(HeartRate.self)
        case "oxygen-saturation": roundTrip(OxygenSaturation.self)
        case "part-of-day": roundTrip(PartOfDay.self)
        case "respiratory-rate": roundTrip(RespiratoryRate.self)
        case "specimen-source": roundTrip(SpecimenSource.self)
        case "step-count": roundTrip(StepCount.self)
        case "temporal-relationship-to-physical-activity": roundTrip(TemporalRelationshipToPhysicalActivity.self)
        case "temporal-relationship-to-sleep": roundTrip(TemporalRelationshipToSleep.self)
        default: nil
        }
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


    @Test("Test data is bundled")
    func testDataIsBundled() {
        #expect(!Self.testFiles.isEmpty)
    }

    @Test("Test data round trip", arguments: testFiles)
    func testDataRoundTrip(file: String) throws {
        let directory = try #require(Self.testDataDirectory)
        let schema = String(file.split(separator: "/")[0])
        let roundTrip = try #require(Self.roundTrip(schema: schema), "No schema registered for \(file)")
        let data = try Data(contentsOf: directory.appending(path: file))
        let reencoded = try roundTrip(data)
        #expect(try JSONDecoder().decode(JSONValue.self, from: reencoded) == JSONDecoder().decode(JSONValue.self, from: data))
    }

    @Test("Blood pressure decodes the body location of previous versions")
    func bloodPressureBodyLocation() throws {
        let json = """
        {"systolic_blood_pressure":{"unit":"mmHg","value":120},"diastolic_blood_pressure":{"unit":"mmHg","value":80},\
        "effective_time_frame":{"date_time":"2024-01-01T00:00:00Z"},"body_location":"left wrist"}
        """
        let bloodPressure = try SchemaCoders.decoder.decode(BloodPressure.self, from: Data(json.utf8))
        #expect(bloodPressure.measurementLocation == .leftWrist)
        let encoded = String(decoding: try SchemaCoders.encoder.encode(bloodPressure), as: UTF8.self)
        #expect(encoded.contains(#""measurement_location":"left wrist""#))
        #expect(!encoded.contains("body_location"))
    }

    @Test("The deprecated blood pressure body location reads and writes the measurement location")
    @available(*, deprecated, message: "Tests the deprecated bodyLocation alias")
    func deprecatedBodyLocation() {
        var bloodPressure = BloodPressure(
            systolicBloodPressure: BloodPressureUnitValue(unit: .mmHg, value: 120),
            diastolicBloodPressure: BloodPressureUnitValue(unit: .mmHg, value: 80),
            effectiveTimeFrame: TimeFrame(dateTime: DateTime(date: Date(timeIntervalSince1970: 1_700_000_000))),
            measurementLocation: .leftWrist
        )
        #expect(bloodPressure.bodyLocation == .leftWrist)
        bloodPressure.bodyLocation = .rightUpperArm
        #expect(bloodPressure.measurementLocation == .rightUpperArm)
    }
}
