//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import OMHModels

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
