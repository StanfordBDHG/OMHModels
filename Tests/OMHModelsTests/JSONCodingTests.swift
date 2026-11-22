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


/// Coders used by the tests. The models encode and decode snake case keys themselves, so no key coding strategy is set.
enum SchemaCoders {
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        return encoder
    }

    static var decoder: JSONDecoder {
        JSONDecoder()
    }
}


@Suite("JSON Coding Tests")
struct JSONCodingTests {
    private static func decode<T: Decodable>(_ type: T.Type, _ json: String, decoder: JSONDecoder = SchemaCoders.decoder) throws -> T {
        try decoder.decode(type, from: Data(json.utf8))
    }

    private static func encode(_ value: some Encodable, encoder: JSONEncoder = SchemaCoders.encoder) throws -> String {
        String(decoding: try encoder.encode(value), as: UTF8.self)
    }


    @Test("Snake case JSON decodes and encodes without a key coding strategy")
    func snakeCaseWithoutKeyStrategy() throws {
        let json = """
        {"effective_time_frame":{"time_interval":{"end_date_time":"2024-01-01T01:00:00Z","start_date_time":"2024-01-01T00:00:00Z"}},\
        "step_count":{"unit":"steps","value":3}}
        """
        let stepCount = try Self.decode(StepCount.self, json)
        #expect(stepCount.stepCount.value == 3)
        #expect(stepCount.effectiveTimeFrame.timeInterval?.startDateTime == (try DateTime("2024-01-01T00:00:00Z")))
        #expect(try Self.encode(stepCount) == json)
    }

    @Test("Time intervals and time frames decode as leniently as in previous versions")
    func timeIntervalLenientDecoding() throws {
        let redundant = try Self.decode(
            OMHModels.TimeInterval.self,
            #"{"start_date_time":"2024-01-01T00:00:00Z","end_date_time":"2024-01-01T01:00:00Z","duration":{"unit":"h","value":1}}"#
        )
        #expect(redundant.duration == DurationUnitValue(unit: .h, value: 1))
        // camelCase keys, as encoded by versions before 0.3.0 without a key coding strategy
        let camelCaseJSON = #"{"startDateTime":"2024-01-01T00:00:00Z","endDateTime":"2024-01-01T01:00:00Z"}"#
        let camelCase = try Self.decode(OMHModels.TimeInterval.self, camelCaseJSON)
        #expect(camelCase.endDateTime == (try DateTime("2024-01-01T01:00:00Z")))
        #expect(throws: DecodingError.self) {
            try Self.decode(TimeFrame.self, "{}")
        }
    }

    @Test("A null snake case key doesn't hide the camelCase key of the same property")
    func nullSnakeCaseKey() throws {
        let json = """
        {"heart_rate":{"unit":"beats/min","value":60},"effective_time_frame":{"date_time":"2024-01-01T00:00:00Z"},\
        "temporal_relationship_to_sleep":null,"temporalRelationshipToSleep":"on waking"}
        """
        #expect(try Self.decode(HeartRate.self, json).temporalRelationshipToSleep == .onWaking)
    }

    @Test("HealthKit units encode as a string and decode the previous nested format")
    func healthKitUnit() throws {
        let value = HealthKitUnitValue(unit: HealthKitUnit(unit: "count"), value: 5)
        #expect(try Self.encode(value) == #"{"unit":"count","value":5}"#)
        #expect(try Self.decode(HealthKitUnitValue.self, #"{"unit":"count","value":5}"#) == value)
        #expect(try Self.decode(HealthKitUnitValue.self, #"{"unit":{"unit":"count"},"value":5}"#) == value)
    }

    @Test("Date-times keep time zone offsets and expose the parsed date")
    func dateTime() throws {
        let date = Date(timeIntervalSince1970: 1_700_000_000.5)
        #expect(DateTime(date: date).value == "2023-11-14T22:13:20Z")
        #expect(DateTime(date: date, includingFractionalSeconds: true).value == "2023-11-14T22:13:20.500Z")

        let pacific = try #require(TimeZone(identifier: "America/Los_Angeles"))
        let pacificDateTime = DateTime(date: date, timeZone: pacific, includingFractionalSeconds: true)
        #expect(pacificDateTime.value == "2023-11-14T14:13:20.500-08:00")
        #expect(pacificDateTime.date == date)

        #expect(try DateTime("2020-02-05T07:25:00+03:00").date == Date(timeIntervalSince1970: 1_580_876_700))
        #expect(throws: DateTimeError.invalidFormat("2020-02-05")) {
            try DateTime("2020-02-05")
        }
        // Decoding is lenient, so existing data that doesn't follow RFC 3339 can still be read.
        let lenient = try Self.decode(DateTime.self, #""2020-02-05T07:25:00""#)
        #expect(lenient.value == "2020-02-05T07:25:00")
        #expect(lenient.date == nil)
    }

    @Test("Deprecated date and part of day time intervals keep the exact date")
    @available(*, deprecated, message: "Tests the deprecated date and part of day time interval")
    func dateAndPartOfDay() throws {
        let date = Date(timeIntervalSince1970: 1_700_000_000.5)
        let timeInterval = OMHModels.TimeInterval(date: date, partOfDay: .morning)
        let decoded = try Self.decode(OMHModels.TimeInterval.self, try Self.encode(timeInterval))
        #expect(decoded.date == date)
        #expect(decoded.partOfDay == .morning)
        // Open mHealth `time-interval-1.0` full dates decode and encode as full dates
        let fullDateJSON = #"{"date":"2023-11-14","part_of_day":"morning"}"#
        let fullDate = try Self.decode(OMHModels.TimeInterval.self, fullDateJSON)
        #expect(fullDate.date == Date(timeIntervalSince1970: 1_699_920_000))
        #expect(try Self.encode(fullDate) == fullDateJSON)
    }

    @Test("Schema IDs accept any namespace")
    func schemaNamespace() throws {
        let schemaId = try Self.decode(SchemaId.self, #"{"name":"x","namespace":"acme","version":"1.0"}"#)
        #expect(schemaId.namespace == "acme")
        // Failable like the previous enum, so existing `if let` code keeps compiling.
        let namespace = try #require(SchemaNamespace(rawValue: "acme"))
        #expect(namespace == schemaId.namespace)
        #expect(try Self.encode(schemaId) == #"{"name":"x","namespace":"acme","version":"1.0"}"#)
    }

    @Test("IEEE 1752 schemas use the ieee namespace")
    func ieeeNamespace() {
        #expect(PhysicalActivity.schemaId.namespace == .ieee)
        #expect(TotalSleepTime.schemaId.namespace == .ieee)
        #expect(BodyPosture.schemaId.namespace == .ieee)
    }

    @Test("Headers treat external datasheets as optional")
    func headerExternalDatasheets() throws {
        let json = """
        {"schema_id":{"name":"step-count","namespace":"omh","version":"3.0"},"source_creation_date_time":"2024-01-01T00:00:00Z","uuid":"x"}
        """
        let header = try Self.decode(Header.self, json)
        #expect(header.externalDatasheets.isEmpty)
    }

    @Test("Frequencies can be expressed in hertz")
    func frequencyInHertz() throws {
        #expect(try Self.decode(FrequencyUnitValue.self, #"{"unit":"Hz","value":60}"#) == .hertz(60))
        #expect(try Self.encode(FrequencyUnitValue.hertz(0.5)) == #"{"unit":"Hz","value":0.5}"#)
        #expect(throws: DecodingError.self) {
            try Self.decode(FrequencyUnitValue.self, #"{"unit":"kHz","value":60}"#)
        }
    }

    @Test("Data points use the body's schema ID")
    func schemaDataPoint() throws {
        let body = BloodPressure(
            systolicBloodPressure: BloodPressureUnitValue(unit: .mmHg, value: 120),
            diastolicBloodPressure: BloodPressureUnitValue(unit: .mmHg, value: 80),
            effectiveTimeFrame: TimeFrame(dateTime: DateTime(date: .now))
        )
        let dataPoint = SchemaDataPoint(body: body, modality: .sensed)
        #expect(dataPoint.header.schemaId == BloodPressure.schemaId)
        #expect(dataPoint.header.modality == .sensed)

        let decoded = try SchemaCoders.decoder.decode(SchemaDataPoint<BloodPressure>.self, from: SchemaCoders.encoder.encode(dataPoint))
        #expect(decoded == dataPoint)
    }

    @Test("Survey items keep categorical codes and nested answer values")
    func surveyAnswers() throws {
        let item = try Self.decode(
            SurveyItem.self,
            #"{"question":{"text":"q"},"answers":[{"value":"Yes","code":1},{"value":{"unit":"kg","value":70,"nested":{"a":[true]}}}]}"#
        )
        #expect(item.answers[0] == SurveyAnswer(SurveyCategoricalAnswer(value: .string("Yes"), code: .number(1))))
        #expect(item.answers[1].value == .object(["unit": "kg", "value": 70, "nested": ["a": [true]]]))

        let unitValueAnswer = try SurveyAnswer(SurveyUnitValueAnswer(value: MassUnitValue(unit: .kg, value: 70)))
        #expect(unitValueAnswer.value == .object(["unit": "kg", "value": 70]))
        #expect(SurveyAnswer(SurveyDateAnswer(value: .yearMonth("2024-05"))).value == .string("2024-05"))
        #expect(SurveyAnswer(try SurveyTimeAnswer(value: "07:30")).value == .string("07:30"))
    }

    @Test("JSON values decode every JSON type")
    func jsonValue() throws {
        let value = try Self.decode(JSONValue.self, #"{"a":"s","b":1.5,"c":true,"d":null,"e":[1,"x"],"f":{}}"#)
        #expect(value == ["a": "s", "b": 1.5, "c": true, "d": nil, "e": [1, "x"], "f": [:]])
        #expect(try Self.decode(JSONValue.self, try Self.encode(value)) == value)

        // Integers beyond the exact range of `Double` are kept exactly.
        let large = #"{"a":9007199254740993}"#
        #expect(try Self.encode(try Self.decode(JSONValue.self, large)) == large)
    }
}
