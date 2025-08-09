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


@Suite("Survey Real World Tests")
struct SurveyRealWorldTests {
    var testDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 2025, month: 1, day: 1, hour: 10, minute: 0, second: 0)
            guard let date = Calendar.current.date(from: dateComponents) else {
                throw TestError.invalidDate
            }
            return date
        }
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
        #expect(decodedSurvey.items[1].answers.isEmpty) // No answer provided
        #expect(decodedSurvey.deliveryDetails.endStatus == .abandoned)
        #expect(decodedSurvey.score == nil)
    }
}
