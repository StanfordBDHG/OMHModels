<!--
                  
This source file is part of the OMHModels open source project

SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# OMHModels

[![CI](https://github.com/StanfordBDHG/OMHModels/actions/workflows/ci.yml/badge.svg)](https://github.com/StanfordBDHG/OMHModels/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/OMHModels/branch/main/graph/badge.svg?token=X7BQYSUKOH)](https://codecov.io/gh/StanfordBDHG/OMHModels)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOMHModels%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/StanfordBDHG/OMHModels)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOMHModels%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordBDHG/OMHModels)
[![DOI](https://zenodo.org/badge/704758245.svg)](https://doi.org/10.5281/zenodo.15581076)

OMHModels is a Swift library for using [Open mHealth](https://www.openmhealth.org/) and [IEEE 1752](https://opensource.ieee.org/omh/1752) schemas to represent mobile health data in iOS projects.

## Installation

The project can be added to your Xcode project or Swift Package using the [Swift Package Manager](https://github.com/swiftlang/swift-package-manager).

**Xcode:** For an Xcode project, follow the instructions on [adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

**Swift Package:** You can follow the [Swift Package Manager documentation about defining dependencies](https://github.com/swiftlang/swift-package-manager/blob/main/Sources/PackageManagerDocs/Documentation.docc/Dependencies/AddingDependencies.md) to add this project as a dependency to your Swift Package.

## Schemas

The following schemas are currently supported by this package:

### IEEE 1752

- [ambient-light](https://w3id.org/ieee/ieee-1752-schema/ambient-light.json)
- [ambient-sound](https://w3id.org/ieee/ieee-1752-schema/ambient-sound.json)
- [ambient-temperature](https://w3id.org/ieee/ieee-1752-schema/ambient-temperature.json)
- [apnea-hypopnea-index](https://w3id.org/ieee/ieee-1752-schema/apnea-hypopnea-index.json)
- [arousal-index](https://w3id.org/ieee/ieee-1752-schema/arousal-index.json)
- [body-posture](https://w3id.org/ieee/ieee-1752-schema/body-posture.json)
- [data-point](https://w3id.org/ieee/ieee-1752-schema/data-point.json)
- [data-series](https://w3id.org/ieee/ieee-1752-schema/data-series.json)
- [date-time](https://w3id.org/ieee/ieee-1752-schema/date-time.json)
- [deep-sleep](https://w3id.org/ieee/ieee-1752-schema/deep-sleep.json)
- [descriptive-statistic](https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic.json)
- [descriptive-statistic-denominator](https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic-denominator.json)
- [duration-unit-value](https://w3id.org/ieee/ieee-1752-schema/duration-unit-value.json)
- [duration-unit-value-range](https://w3id.org/ieee/ieee-1752-schema/duration-unit-value-range.json)
- [frequency-unit-value](https://w3id.org/ieee/ieee-1752-schema/frequency-unit-value.json)
- [header](https://w3id.org/ieee/ieee-1752-schema/header.json)
- [illuminance-unit-value](https://w3id.org/ieee/ieee-1752-schema/illuminance-unit-value.json)
- [kcal-unit-value](https://w3id.org/ieee/ieee-1752-schema/kcal-unit-value.json)
- [length-unit-value](https://w3id.org/ieee/ieee-1752-schema/length-unit-value.json)
- [light-sleep](https://w3id.org/ieee/ieee-1752-schema/light-sleep.json)
- [percent-unit-value](https://w3id.org/ieee/ieee-1752-schema/percent-unit-value.json)
- [physical-activity](https://w3id.org/ieee/ieee-1752-schema/physical-activity.json)
- [schema-id](https://w3id.org/ieee/ieee-1752-schema/schema-id.json)
- [sleep-episode](https://w3id.org/ieee/ieee-1752-schema/sleep-episode.json)
- [sleep-onset-latency](https://w3id.org/ieee/ieee-1752-schema/sleep-onset-latency.json)
- [sleep-stage-summary](https://w3id.org/ieee/ieee-1752-schema/sleep-stage-summary.json)
- [snore-index](https://w3id.org/ieee/ieee-1752-schema/snore-index.json)
- [sound-unit-value](https://w3id.org/ieee/ieee-1752-schema/sound-unit-value.json)
- [speed-unit-value](https://w3id.org/ieee/ieee-1752-schema/speed-unit-value.json)
- [survey](https://w3id.org/ieee/ieee-1752-schema/survey.json)
- [survey-answer](https://w3id.org/ieee/ieee-1752-schema/survey-answer.json)
- [survey-categorical-answer](https://w3id.org/ieee/ieee-1752-schema/survey-categorical-answer.json)
- [survey-date-answer](https://w3id.org/ieee/ieee-1752-schema/survey-date-answer.json)
- [survey-item](https://w3id.org/ieee/ieee-1752-schema/survey-item.json)
- [survey-question](https://w3id.org/ieee/ieee-1752-schema/survey-question.json)
- [survey-time-answer](https://w3id.org/ieee/ieee-1752-schema/survey-time-answer.json)
- [survey-unit-value-answer](https://w3id.org/ieee/ieee-1752-schema/survey-unit-value-answer.json)
- [temperature-unit-value](https://w3id.org/ieee/ieee-1752-schema/temperature-unit-value.json)
- [time-frame](https://w3id.org/ieee/ieee-1752-schema/time-frame.json)
- [time-in-bed](https://w3id.org/ieee/ieee-1752-schema/time-in-bed.json)
- [time-interval](https://w3id.org/ieee/ieee-1752-schema/time-interval.json)
- [total-sleep-time](https://w3id.org/ieee/ieee-1752-schema/total-sleep-time.json)
- [unit-value](https://w3id.org/ieee/ieee-1752-schema/unit-value.json)
- [unit-value-range](https://w3id.org/ieee/ieee-1752-schema/unit-value-range.json)
- [wake-after-sleep-onset](https://w3id.org/ieee/ieee-1752-schema/wake-after-sleep-onset.json)

### Open mHealth (OMH)

- [blood-glucose 3.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/blood-glucose-3.0.json)
- [blood-pressure 3.1](https://github.com/openmhealth/schemas/blob/main/schema/omh/blood-pressure-3.1.json)
- [body-fat-percentage 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-fat-percentage-1.0.json)
- [body-height 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-height-1.0.json)
- [body-location 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-location-1.0.json)
- [body-mass-index 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-mass-index-2.0.json)
- [body-temperature 3.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-temperature-3.0.json)
- [body-weight 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-weight-2.0.json)
- [geoposition 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/geoposition-2.0.json)
- [heart-rate 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/heart-rate-2.0.json)
- [mass-unit-value 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/mass-unit-value-1.0.json)
- [oxygen-saturation 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/oxygen-saturation-2.0.json)
- [part-of-day 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/part-of-day-1.0.json)
- [plane-angle-unit-value 1.1](https://github.com/openmhealth/schemas/blob/main/schema/omh/plane-angle-unit-value-1.1.json)
- [respiratory-rate 2.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/respiratory-rate-2.0.json)
- [specimen-source 2.1](https://github.com/openmhealth/schemas/blob/main/schema/omh/specimen-source-2.1.json)
- [step-count 3.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/step-count-3.0.json)
- [temporal-relationship-to-meal 1.2](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-meal-1.2.json)
- [temporal-relationship-to-physical-activity 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-physical-activity-1.0.json)
- [temporal-relationship-to-sleep 1.0](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-sleep-1.0.json)

The package also includes the `granola:hk-quantity-sample` schema for HealthKit quantity samples.

## Usage Example

The `OMHModels` package can be used to represent mobile health data in accordance with the above schemas within your iOS application. 

Below is an example using `TotalSleepTime`, although the same instructions apply to any schema in the package.

### Initialization 

To create an instance of the `TotalSleepTime` struct:

```swift
let sleepTime = TotalSleepTime(
    totalSleepTime: DurationUnitValue(unit: .h, value: 8),
    effectiveTimeFrame: TimeFrame(
        timeInterval: OMHModels.TimeInterval(
            startDateTime: DateTime(date: startDate),
            endDateTime: DateTime(date: endDate)
        )
    ),
    isMainSleep: true
)
```

> [!NOTE]
> `OMHModels.TimeInterval` shares its name with `Foundation.TimeInterval`. Qualify it with the module name in files that import Foundation.

To wrap a schema in an IEEE 1752 data point with a header:

```swift
let dataPoint = SchemaDataPoint(body: sleepTime, modality: .sensed)
```

### Encoding to JSON 

The models encode and decode the snake case property names used by IEEE 1752 and Open mHealth themselves, so no `keyEncodingStrategy` or `keyDecodingStrategy` is needed. Coders that still set the `convertToSnakeCase` and `convertFromSnakeCase` strategies recommended by earlier versions keep working.

```swift
let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]

let data = try encoder.encode(dataPoint)
let json = String(decoding: data, as: UTF8.self)
```

### Decoding from JSON

```swift
let dataPoint = try JSONDecoder().decode(SchemaDataPoint<TotalSleepTime>.self, from: data)
```

Data encoded by earlier versions of OMHModels, with or without key coding strategies, still decodes.

> [!IMPORTANT]
> The models only keep the properties defined by their schemas. Other properties in the JSON are dropped when decoding, so decoding and encoding data again loses them. Keep the original JSON if you need to preserve it unchanged.

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/OMHModels/tree/main/LICENSES) for more information.

## Notice
This project is not officially endorsed by Open mHealth or IEEE.

## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/OMHModels/tree/main/CONTRIBUTORS.md) for a full list of all OMHModels contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
