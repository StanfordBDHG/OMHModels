//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels
import Testing


@Suite("Survey Tests")
struct SurveyTests {
    var testDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 2025, month: 1, day: 1, hour: 10, minute: 0, second: 0)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
    }
    
    @Test("Survey Question")
    func testSurveyQuestion() {
        let questionWithLabel = SurveyQuestion(text: "How are you feeling today?", label: "mood_question")
        
        #expect(questionWithLabel.text == "How are you feeling today?")
        #expect(questionWithLabel.label == "mood_question")
        #expect(SurveyQuestion.schemaId.namespace == .ieee)
        #expect(SurveyQuestion.schemaId.name == "survey-question")
        #expect(SurveyQuestion.schemaId.version == "1.0")
        
        let questionWithoutLabel = SurveyQuestion(text: "What is your age?")
        
        #expect(questionWithoutLabel.text == "What is your age?")
        #expect(questionWithoutLabel.label == nil)
    }
    
    @Test("Survey Answer Value")
    func testSurveyAnswerValue() throws {
        let stringValue = SurveyAnswerValue.string("Good")
        let numberValue = SurveyAnswerValue.number(25.5)
        let boolValue = SurveyAnswerValue.boolean(true)
        let objectValue = SurveyAnswerValue.object(["key": "value"])
        
        // Test encoding and decoding
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // Test string value
        let stringData = try encoder.encode(stringValue)
        let decodedStringValue = try decoder.decode(SurveyAnswerValue.self, from: stringData)
        #expect(decodedStringValue == stringValue)
        
        // Test number value
        let numberData = try encoder.encode(numberValue)
        let decodedNumberValue = try decoder.decode(SurveyAnswerValue.self, from: numberData)
        #expect(decodedNumberValue == numberValue)
        
        // Test boolean value
        let boolData = try encoder.encode(boolValue)
        let decodedBoolValue = try decoder.decode(SurveyAnswerValue.self, from: boolData)
        #expect(decodedBoolValue == boolValue)
        
        // Test object value
        let objectData = try encoder.encode(objectValue)
        let decodedObjectValue = try decoder.decode(SurveyAnswerValue.self, from: objectData)
        #expect(decodedObjectValue == objectValue)
    }
    
    @Test("Survey Answer")
    func testSurveyAnswer() {
        let answer = SurveyAnswer(value: .string("Excellent"))
        
        #expect(answer.value == .string("Excellent"))
        #expect(SurveyAnswer.schemaId.namespace == .ieee)
        #expect(SurveyAnswer.schemaId.name == "survey-answer")
        #expect(SurveyAnswer.schemaId.version == "1.0")
    }
    
    @Test("Survey Categorical Answer")
    func testSurveyCategoricalAnswer() {
        let categoricalAnswer = SurveyCategoricalAnswer(
            value: .string("Very Good"),
            code: .string("VG")
        )
        
        #expect(categoricalAnswer.value == .string("Very Good"))
        #expect(categoricalAnswer.code == .string("VG"))
        #expect(SurveyCategoricalAnswer.schemaId.namespace == .ieee)
        #expect(SurveyCategoricalAnswer.schemaId.name == "survey-categorical-answer")
        #expect(SurveyCategoricalAnswer.schemaId.version == "1.0")
        
        let categoricalAnswerWithNumberCode = SurveyCategoricalAnswer(
            value: .number(5),
            code: .number(1)
        )
        
        #expect(categoricalAnswerWithNumberCode.value == .number(5))
        #expect(categoricalAnswerWithNumberCode.code == .number(1))
    }
    
    @Test("Survey Unit Value Answer")
    func testSurveyUnitValueAnswer() {
        let unitValueAnswer = SurveyUnitValueAnswer(
            value: TypedUnitValue<MassUnit>(unit: .kg, value: 70.5)
        )
        
        #expect(unitValueAnswer.value.unit == .kg)
        #expect(unitValueAnswer.value.value == 70.5)
        #expect(SurveyUnitValueAnswer<MassUnit>.schemaId.namespace == .ieee)
        #expect(SurveyUnitValueAnswer<MassUnit>.schemaId.name == "survey-unit-value-answer")
        #expect(SurveyUnitValueAnswer<MassUnit>.schemaId.version == "1.0")
    }
    
    @Test("Survey Date Answer")
    func testSurveyDateAnswer() throws {
        let fullDateAnswer = SurveyDateAnswer(value: .fullDate("2025-01-01"))
        let yearMonthAnswer = SurveyDateAnswer(value: .yearMonth("2025-01"))
        let yearOnlyAnswer = SurveyDateAnswer(value: .yearOnly("2025"))
        
        #expect(fullDateAnswer.value == .fullDate("2025-01-01"))
        #expect(yearMonthAnswer.value == .yearMonth("2025-01"))
        #expect(yearOnlyAnswer.value == .yearOnly("2025"))
        #expect(SurveyDateAnswer.schemaId.namespace == .ieee)
        #expect(SurveyDateAnswer.schemaId.name == "survey-date-answer")
        #expect(SurveyDateAnswer.schemaId.version == "1.0")
        
        // Test encoding and decoding
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let fullDateData = try encoder.encode(fullDateAnswer)
        let decodedFullDateAnswer = try decoder.decode(SurveyDateAnswer.self, from: fullDateData)
        #expect(decodedFullDateAnswer.value == .fullDate("2025-01-01"))
    }
    
    @Test("Survey Time Answer")
    func testSurveyTimeAnswer() throws {
        let timeAnswer = try SurveyTimeAnswer(value: "14:30")
        
        #expect(timeAnswer.value == "14:30")
        #expect(SurveyTimeAnswer.schemaId.namespace == .ieee)
        #expect(SurveyTimeAnswer.schemaId.name == "survey-time-answer")
        #expect(SurveyTimeAnswer.schemaId.version == "1.0")
        
        // Test invalid time format
        #expect(throws: SurveyTimeAnswerError.invalidTimeFormat) {
            _ = try SurveyTimeAnswer(value: "25:00")
        }
        
        #expect(throws: SurveyTimeAnswerError.invalidTimeFormat) {
            _ = try SurveyTimeAnswer(value: "14:60")
        }
        
        #expect(throws: SurveyTimeAnswerError.invalidTimeFormat) {
            _ = try SurveyTimeAnswer(value: "2:30")
        }
    }
    
    @Test("Survey Item")
    func testSurveyItem() throws {
        let question = SurveyQuestion(text: "How do you feel?", label: "mood")
        let answer = SurveyAnswer(value: .string("Great"))
        let askedDateTime = DateTime(date: try testDate)
        let answeredDateTime = DateTime(date: try testDate.addingTimeInterval(60))
        
        let surveyItem = SurveyItem(
            question: question,
            answers: [answer],
            askedDateTime: askedDateTime,
            answeredDateTime: answeredDateTime
        )
        
        #expect(surveyItem.question.text == "How do you feel?")
        #expect(surveyItem.answers.count == 1)
        #expect(surveyItem.answers[0].value == .string("Great"))
        #expect(surveyItem.askedDateTime == askedDateTime)
        #expect(surveyItem.answeredDateTime == answeredDateTime)
        #expect(SurveyItem.schemaId.namespace == .ieee)
        #expect(SurveyItem.schemaId.name == "survey-item")
        #expect(SurveyItem.schemaId.version == "1.0")
        
        let emptyAnswerItem = SurveyItem(question: question)
        #expect(emptyAnswerItem.answers.isEmpty)
        #expect(emptyAnswerItem.askedDateTime == nil)
        #expect(emptyAnswerItem.answeredDateTime == nil)
    }
    
    @Test("Survey Delivery Details")
    func testSurveyDeliveryDetails() throws {
        let startDateTime = DateTime(date: try testDate)
        let endDateTime = DateTime(date: try testDate.addingTimeInterval(300))
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: startDateTime,
            endDateTime: endDateTime,
            endStatus: .completed
        )
        
        #expect(deliveryDetails.startDateTime == startDateTime)
        #expect(deliveryDetails.endDateTime == endDateTime)
        #expect(deliveryDetails.endStatus == .completed)
        
        let emptyDeliveryDetails = SurveyDeliveryDetails()
        #expect(emptyDeliveryDetails.startDateTime == nil)
        #expect(emptyDeliveryDetails.endDateTime == nil)
        #expect(emptyDeliveryDetails.endStatus == nil)
    }
    
    @Test("Survey End Status")
    func testSurveyEndStatus() {
        #expect(SurveyEndStatus.completed.rawValue == "completed")
        #expect(SurveyEndStatus.abandoned.rawValue == "abandoned")
        #expect(SurveyEndStatus.missed.rawValue == "missed")
    }
    
    @Test("Survey Score")
    func testSurveyScore() throws {
        let numberScore = SurveyScore.number(85.5)
        let objectScore = SurveyScore.object(["totalScore": "85", "maxScore": "100"])
        
        // Test encoding and decoding
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let numberData = try encoder.encode(numberScore)
        let decodedNumberScore = try decoder.decode(SurveyScore.self, from: numberData)
        #expect(decodedNumberScore == numberScore)
        
        let objectData = try encoder.encode(objectScore)
        let decodedObjectScore = try decoder.decode(SurveyScore.self, from: objectData)
        #expect(decodedObjectScore == objectScore)
    }
    
    @Test("Survey")
    func testSurvey() throws {
        let question1 = SurveyQuestion(text: "How do you feel?", label: "mood")
        let question2 = SurveyQuestion(text: "What is your age?", label: "age")
        
        let answer1 = SurveyAnswer(value: .string("Good"))
        let answer2 = SurveyAnswer(value: .number(25))
        
        let item1 = SurveyItem(question: question1, answers: [answer1])
        let item2 = SurveyItem(question: question2, answers: [answer2])
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: DateTime(date: try testDate),
            endDateTime: DateTime(date: try testDate.addingTimeInterval(300)),
            endStatus: .completed
        )
        
        let survey = Survey(
            items: [item1, item2],
            deliveryDetails: deliveryDetails,
            score: .number(90.0)
        )
        
        #expect(survey.items.count == 2)
        #expect(survey.items[0].question.text == "How do you feel?")
        #expect(survey.items[1].question.text == "What is your age?")
        #expect(survey.deliveryDetails.endStatus == .completed)
        #expect(survey.score == .number(90.0))
        #expect(Survey.schemaId.namespace == .ieee)
        #expect(Survey.schemaId.name == "survey")
        #expect(Survey.schemaId.version == "1.0")
        
        let surveyWithoutScore = Survey(
            items: [item1],
            deliveryDetails: deliveryDetails
        )
        
        #expect(surveyWithoutScore.score == nil)
        #expect(surveyWithoutScore.items.count == 1)
    }
    
    @Test("Survey JSON Serialization")
    func testSurveyJSONSerialization() throws {
        let question = SurveyQuestion(text: "Rate your satisfaction", label: "satisfaction")
        let answer = SurveyAnswer(value: .number(8))
        let item = SurveyItem(question: question, answers: [answer])
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: DateTime(date: try testDate),
            endDateTime: DateTime(date: try testDate.addingTimeInterval(120)),
            endStatus: .completed
        )
        
        let survey = Survey(
            items: [item],
            deliveryDetails: deliveryDetails,
            score: .number(8.0)
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let surveyData = try encoder.encode(survey)
        let decodedSurvey = try decoder.decode(Survey.self, from: surveyData)
        
        #expect(decodedSurvey.items.count == 1)
        #expect(decodedSurvey.items[0].question.text == "Rate your satisfaction")
        #expect(decodedSurvey.items[0].answers[0].value == .number(8))
        #expect(decodedSurvey.deliveryDetails.endStatus == .completed)
        #expect(decodedSurvey.score == .number(8.0))
    }
    
    @Test("PHQ-9 Depression Survey")
    func testPHQ9DepressionSurvey() throws {
        let startTime = try testDate
        let endTime = startTime.addingTimeInterval(180)
        
        // PHQ-9 questions with realistic labels
        let questions = [
            ("Over the last 2 weeks, how often have you been bothered by little interest or pleasure in doing things?", "phq9_interest"),
            ("Feeling down, depressed, or hopeless?", "phq9_depressed"),
            ("Trouble falling or staying asleep, or sleeping too much?", "phq9_sleep"),
            ("Feeling tired or having little energy?", "phq9_energy")
        ]
        
        // Sample answers (0=Not at all, 1=Several days, 2=More than half the days, 3=Nearly every day)
        let sampleAnswers = [1, 2, 1, 2]
        
        var surveyItems: [SurveyItem] = []
        
        for (index, (questionText, label)) in questions.enumerated() {
            let question = SurveyQuestion(text: questionText, label: label)
            let answer = SurveyAnswer(value: .number(Double(sampleAnswers[index])))
            
            let item = SurveyItem(
                question: question,
                answers: [answer],
                askedDateTime: DateTime(date: startTime.addingTimeInterval(Double(index * 15))),
                answeredDateTime: DateTime(date: startTime.addingTimeInterval(Double(index * 15 + 10)))
            )
            surveyItems.append(item)
        }
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: DateTime(date: startTime),
            endDateTime: DateTime(date: endTime),
            endStatus: .completed
        )
        
        let totalScore = sampleAnswers.reduce(0, +)
        
        let survey = Survey(
            items: surveyItems,
            deliveryDetails: deliveryDetails,
            score: .number(Double(totalScore))
        )
        
        // Test JSON serialization
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let surveyData = try encoder.encode(survey)
        let decodedSurvey = try decoder.decode(Survey.self, from: surveyData)
        
        #expect(decodedSurvey.items.count == 4)
        #expect(decodedSurvey.deliveryDetails.endStatus == .completed)
        #expect(decodedSurvey.score == .number(6.0))
        #expect(decodedSurvey.items[0].question.label == "phq9_interest")
        #expect(decodedSurvey.items[0].answers[0].value == .number(1))
    }
    
    @Test("Medical History Survey Mixed Types")
    func testMedicalHistorySurveyMixedTypes() throws {
        let startTime = try testDate
        
        var items: [SurveyItem] = []
        
        // Date of birth question
        let dobQuestion = SurveyQuestion(text: "What is your date of birth?", label: "date_of_birth")
        let dobSurveyAnswer = SurveyAnswer(value: .string("1985-03-15"))
        let dobItem = SurveyItem(question: dobQuestion, answers: [dobSurveyAnswer])
        items.append(dobItem)
        
        // Weight question
        let weightQuestion = SurveyQuestion(text: "What is your current weight?", label: "current_weight")
        let weightSurveyAnswer = SurveyAnswer(value: .number(70.5))
        let weightItem = SurveyItem(question: weightQuestion, answers: [weightSurveyAnswer])
        items.append(weightItem)
        
        // Medication time question
        let medicationQuestion = SurveyQuestion(text: "What time do you usually take your medication?", label: "medication_time")
        let timeSurveyAnswer = SurveyAnswer(value: .string("08:30"))
        let medicationItem = SurveyItem(question: medicationQuestion, answers: [timeSurveyAnswer])
        items.append(medicationItem)
        
        // Yes/No question
        let smokerQuestion = SurveyQuestion(text: "Do you currently smoke?", label: "current_smoker")
        let smokerAnswer = SurveyAnswer(value: .boolean(false))
        let smokerItem = SurveyItem(question: smokerQuestion, answers: [smokerAnswer])
        items.append(smokerItem)
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: DateTime(date: startTime),
            endDateTime: DateTime(date: startTime.addingTimeInterval(300)),
            endStatus: .completed
        )
        
        let survey = Survey(
            items: items,
            deliveryDetails: deliveryDetails,
            score: .object(["completeness": "100", "validity": "high"])
        )
        
        // Test JSON serialization
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let surveyData = try encoder.encode(survey)
        let decodedSurvey = try decoder.decode(Survey.self, from: surveyData)
        
        #expect(decodedSurvey.items.count == 4)
        #expect(decodedSurvey.items[0].answers[0].value == .string("1985-03-15"))
        #expect(decodedSurvey.items[1].answers[0].value == .number(70.5))
        #expect(decodedSurvey.items[2].answers[0].value == .string("08:30"))
        #expect(decodedSurvey.items[3].answers[0].value == .boolean(false))
        #expect(decodedSurvey.score == .object(["completeness": "100", "validity": "high"]))
    }
    
    @Test("Abandoned Survey Scenario")
    func testAbandonedSurveyScenario() throws {
        let startTime = try testDate
        
        let question1 = SurveyQuestion(text: "How satisfied are you with our service?", label: "satisfaction")
        let answer1 = SurveyAnswer(value: .number(8))
        let item1 = SurveyItem(question: question1, answers: [answer1])
        
        // Second question was presented but not answered (abandoned)
        let question2 = SurveyQuestion(text: "Would you recommend us to others?", label: "recommendation")
        let item2 = SurveyItem(
            question: question2,
            answers: [], // No answer provided
            askedDateTime: DateTime(date: startTime.addingTimeInterval(30)),
            answeredDateTime: nil
        )
        
        let deliveryDetails = SurveyDeliveryDetails(
            startDateTime: DateTime(date: startTime),
            endDateTime: DateTime(date: startTime.addingTimeInterval(45)),
            endStatus: .abandoned
        )
        
        let survey = Survey(
            items: [item1, item2],
            deliveryDetails: deliveryDetails,
            score: nil // No score for abandoned survey
        )
        
        // Test JSON serialization
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let surveyData = try encoder.encode(survey)
        let decodedSurvey = try decoder.decode(Survey.self, from: surveyData)
        
        #expect(decodedSurvey.items.count == 2)
        #expect(decodedSurvey.items[0].answers.count == 1)
        #expect(decodedSurvey.items[1].answers.count == 0) // No answer provided
        #expect(decodedSurvey.deliveryDetails.endStatus == .abandoned)
        #expect(decodedSurvey.score == nil)
    }
}

// MARK: - Equatable Extensions for Testing

extension SurveyAnswerValue: Equatable {
    public static func == (lhs: SurveyAnswerValue, rhs: SurveyAnswerValue) -> Bool {
        switch (lhs, rhs) {
        case let (.string(lhsValue), .string(rhsValue)):
            return lhsValue == rhsValue
        case let (.number(lhsValue), .number(rhsValue)):
            return lhsValue == rhsValue
        case let (.boolean(lhsValue), .boolean(rhsValue)):
            return lhsValue == rhsValue
        case let (.object(lhsValue), .object(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

extension SurveyCategoricalCode: Equatable {
    public static func == (lhs: SurveyCategoricalCode, rhs: SurveyCategoricalCode) -> Bool {
        switch (lhs, rhs) {
        case let (.string(lhsValue), .string(rhsValue)):
            return lhsValue == rhsValue
        case let (.number(lhsValue), .number(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

extension SurveyDateValue: Equatable {
    public static func == (lhs: SurveyDateValue, rhs: SurveyDateValue) -> Bool {
        switch (lhs, rhs) {
        case let (.fullDate(lhsValue), .fullDate(rhsValue)),
             let (.yearMonth(lhsValue), .yearMonth(rhsValue)),
             let (.yearOnly(lhsValue), .yearOnly(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

extension SurveyScore: Equatable {
    public static func == (lhs: SurveyScore, rhs: SurveyScore) -> Bool {
        switch (lhs, rhs) {
        case let (.number(lhsValue), .number(rhsValue)):
            return lhsValue == rhsValue
        case let (.object(lhsValue), .object(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}
