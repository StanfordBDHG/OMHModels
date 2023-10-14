//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents the temporal relationship of a clinical measure or assessment to meals (e.g., fasting, after lunch).
/// Generated from Open mHealth `omh:temporal-relationship-to-meal:1.2` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-meal)
public enum TemporalRelationshipToMeal: String, Schema {
    case fasting
    case notFasting = "not fasting"
    case beforeMeal = "before meal"
    case afterMeal = "after meal"
    case beforeBreakfast = "before breakfast"
    case afterBreakfast = "after breakfast"
    case beforeLunch = "before lunch"
    case afterLunch = "after lunch"
    case beforeDinner = "before dinner"
    case afterDinner = "after dinner"
    case twoHoursPostprandial = "2 hours postprandial"
    case withMeal = "with meal"
    case withFood = "with food"
    
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "temporal-relationship-to-meal", version: "1.2")
}
