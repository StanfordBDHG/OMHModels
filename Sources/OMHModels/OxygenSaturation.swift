//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The method by which the oxygen saturation is measured. Currently, pulse oximetry is teh only method used for measuring oxygen saturation in a non-hospital setting.
public enum OxygenSaturationMeasurementMethod: String, Codable, Sendable {
    case pulseOximetry = "pulse oximetry"
}

/// Oxygen saturation can be measured at different levels in the body and is labeled accordingly: peripheral, arterial, etc.
public enum OxygenSaturationMeasurementSystem: String, Codable, Sendable {
    case peripheralCapillary = "peripheral capillary"
}

public enum OxygenTherapyModeOfAdministration: String, Codable, Sendable {
    case nasalCannula = "nasal cannula"
}

/// An Oxygen Saturation measurement
/// Generated from Open mHealth `omh:oxygen-saturation:2.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_oxygen-saturation)
public struct OxygenSaturation: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "oxygen-saturation", version: "2.0")
    
    /// The oxygen saturation measurement as a `UnitValue` containing a double value and a unit
    public var oxygenSaturation: OxygenSaturationUnitValue
    
    /// The method by which oxygen saturation is measured
    public var measurementMethod: OxygenSaturationMeasurementMethod?
    
    /// The mode of administration for supplemental oxygen
    public var oxygenTherapyModeOfAdministration: OxygenTherapyModeOfAdministration?
    
    /// The flow rate of supplemental oxygen
    public var supplementalOxygenFlowRate: SupplementalOxygenFlowRateUnitValue?
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    public init(
        oxygenSaturation: OxygenSaturationUnitValue,
        effectiveTimeFrame: TimeFrame,
        measurementMethod: OxygenSaturationMeasurementMethod? = nil,
        oxygenTherapyModeOfAdministration: OxygenTherapyModeOfAdministration? = nil,
        supplementalOxygenFlowRate: SupplementalOxygenFlowRateUnitValue? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.oxygenSaturation = oxygenSaturation
        self.effectiveTimeFrame = effectiveTimeFrame
        self.measurementMethod = measurementMethod
        self.oxygenTherapyModeOfAdministration = oxygenTherapyModeOfAdministration
        self.supplementalOxygenFlowRate = supplementalOxygenFlowRate
        self.descriptiveStatistic = descriptiveStatistic
    }
}
