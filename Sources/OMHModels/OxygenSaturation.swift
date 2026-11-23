//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// The method by which the oxygen saturation is measured. Currently, pulse oximetry is the only method used for measuring oxygen saturation in a non-hospital setting.
public enum OxygenSaturationMeasurementMethod: String, Codable, Sendable {
    case pulseOximetry = "pulse oximetry"
}

/// Oxygen saturation can be measured at different levels in the body and is labeled accordingly: peripheral, arterial, etc.
public enum OxygenSaturationMeasurementSystem: String, Codable, Sendable {
    case peripheralCapillary = "peripheral capillary"
}

/// The mode of administration of supplemental oxygen therapy
public enum OxygenTherapyModeOfAdministration: String, Codable, Sendable {
    case nasalCannula = "nasal cannula"
}

/// An Oxygen Saturation measurement
/// Generated from Open mHealth `omh:oxygen-saturation:3.0` (https://w3id.org/openmhealth/schemas/omh/oxygen-saturation-3.0.json)
public struct OxygenSaturation: Schema, Equatable {
    private enum CodingKeys: String, CodingKey {
        case oxygenSaturation = "oxygen_saturation"
        case system
        case measurementMethod = "measurement_method"
        case oxygenTherapyModeOfAdministration = "oxygen_therapy_mode_of_administration"
        case supplementalOxygenFlowRate = "supplemental_oxygen_flow_rate"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "oxygen-saturation", version: "3.0")
    
    /// The oxygen saturation measurement as a `UnitValue` containing a double value and a unit
    public var oxygenSaturation: OxygenSaturationUnitValue
    
    /// The level in the body at which oxygen saturation is measured
    public var system: OxygenSaturationMeasurementSystem?
    
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
        system: OxygenSaturationMeasurementSystem? = nil,
        measurementMethod: OxygenSaturationMeasurementMethod? = nil,
        oxygenTherapyModeOfAdministration: OxygenTherapyModeOfAdministration? = nil,
        supplementalOxygenFlowRate: SupplementalOxygenFlowRateUnitValue? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.oxygenSaturation = oxygenSaturation
        self.effectiveTimeFrame = effectiveTimeFrame
        self.system = system
        self.measurementMethod = measurementMethod
        self.oxygenTherapyModeOfAdministration = oxygenTherapyModeOfAdministration
        self.supplementalOxygenFlowRate = supplementalOxygenFlowRate
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        oxygenSaturation = try container.decode(OxygenSaturationUnitValue.self, forKey: .oxygenSaturation)
        system = try container.decodeIfPresent(OxygenSaturationMeasurementSystem.self, forKey: .system)
        measurementMethod = try container.decodeIfPresent(OxygenSaturationMeasurementMethod.self, forKey: .measurementMethod)
        oxygenTherapyModeOfAdministration = try container.decodeIfPresent(
            OxygenTherapyModeOfAdministration.self,
            forKey: .oxygenTherapyModeOfAdministration
        )
        supplementalOxygenFlowRate = try container.decodeIfPresent(SupplementalOxygenFlowRateUnitValue.self, forKey: .supplementalOxygenFlowRate)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
