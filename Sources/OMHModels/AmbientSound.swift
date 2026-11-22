//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// The sound level of the environment surrounding a person
/// Generated from IEEE 1752.1 `ambient-sound-1.0` (https://w3id.org/ieee/ieee-1752-schema/ambient-sound.json)
public struct AmbientSound: Schema, Hashable {
    private enum CodingKeys: String, CodingKey {
        case ambientSound = "ambient_sound"
        case effectiveTimeFrame = "effective_time_frame"
        case descriptiveStatistic = "descriptive_statistic"
    }

    /// The IEEE 1752 schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "ambient-sound", version: "1.0")

    /// The ambient sound level
    public var ambientSound: SoundUnitValue

    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame

    /// The descriptive statistic of a set of measurements (e.g., average, maximum) within the specified time frame
    public var descriptiveStatistic: DescriptiveStatistic?


    public init(
        ambientSound: SoundUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.ambientSound = ambientSound
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
    }

    public init(from decoder: any Decoder) throws {
        let container = try KeyStrategyTolerantContainer(decoder: decoder, keyedBy: CodingKeys.self)
        ambientSound = try container.decode(SoundUnitValue.self, forKey: .ambientSound)
        effectiveTimeFrame = try container.decode(TimeFrame.self, forKey: .effectiveTimeFrame)
        descriptiveStatistic = try container.decodeIfPresent(DescriptiveStatistic.self, forKey: .descriptiveStatistic)
    }
}
