//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A coding key with an arbitrary string value.
struct AnyCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int? = nil


    init(_ stringValue: String) {
        self.stringValue = stringValue
    }

    init(stringValue: String) {
        self.init(stringValue)
    }

    init?(intValue: Int) {
        nil
    }
}


/// A keyed decoding container that finds a snake case key (e.g., `start_date_time`) both in plain JSON
/// and when a `JSONDecoder` uses the `convertFromSnakeCase` key decoding strategy (which turns it into `startDateTime`).
///
/// Versions before 0.3.0 relied on key coding strategies: JSON encoded without a strategy uses camelCase keys,
/// and some schemas decoded with `convertFromSnakeCase`. All schemas decode through this container,
/// so data encoded by earlier versions and decoders that still set the strategy keep working.
struct KeyStrategyTolerantContainer<Key: CodingKey> {
    private let container: KeyedDecodingContainer<AnyCodingKey>


    init(decoder: any Decoder, keyedBy type: Key.Type) throws {
        container = try decoder.container(keyedBy: AnyCodingKey.self)
    }


    private static func camelCase(_ snakeCase: String) -> String {
        let components = snakeCase.split(separator: "_")
        guard let first = components.first else {
            return snakeCase
        }
        return String(first) + components.dropFirst().map { $0.prefix(1).uppercased() + $0.dropFirst() }.joined()
    }

    private func resolve(_ key: Key) -> AnyCodingKey {
        let snakeCaseKey = AnyCodingKey(key.stringValue)
        let convertedKey = AnyCodingKey(Self.camelCase(key.stringValue))
        guard container.contains(convertedKey) else {
            return snakeCaseKey
        }
        // Prefer the snake case key unless it's missing or null and the converted key has a value.
        let snakeCaseIsNull = (try? container.decodeNil(forKey: snakeCaseKey)) ?? true
        let convertedIsNull = (try? container.decodeNil(forKey: convertedKey)) ?? true
        return snakeCaseIsNull && !convertedIsNull ? convertedKey : snakeCaseKey
    }

    func contains(_ key: Key) -> Bool {
        container.contains(resolve(key))
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        try container.decode(type, forKey: resolve(key))
    }

    func decodeIfPresent<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T? {
        try container.decodeIfPresent(type, forKey: resolve(key))
    }
}
