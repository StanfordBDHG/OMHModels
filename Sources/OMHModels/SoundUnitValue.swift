//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


// swiftlint:disable identifier_name
// We disable this rule because we must use the unit names defined by IEEE 1752
/// Units for a sound level
public enum SoundUnit: String, UnitProtocol, Hashable {
    case dB
    case dBA
}
// swiftlint:enable identifier_name

/// A type representing a sound level
/// Generated from IEEE 1752.1 `sound-unit-value-1.0` (https://w3id.org/ieee/ieee-1752-schema/sound-unit-value.json)
public typealias SoundUnitValue = TypedUnitValue<SoundUnit>
