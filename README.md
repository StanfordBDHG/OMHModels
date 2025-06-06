<!--
                  
This source file is part of the OMHModels open source project

SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# OMHModels

[![Build and Test](https://github.com/StanfordBDHG/OMHModels/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordBDHG/OMHModels/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/OMHModels/branch/main/graph/badge.svg?token=X7BQYSUKOH)](https://codecov.io/gh/StanfordBDHG/SwiftPackageTemplate)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOMHModels%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/StanfordBDHG/OMHModels)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOMHModels%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordBDHG/OMHModels)
[![DOI](https://zenodo.org/badge/704758245.svg)](https://doi.org/10.5281/zenodo.15581076)

OMHModels is a Swift library for using [Open mHealth](https://www.openmhealth.org/) and [IEEE 1752](https://opensource.ieee.org/omh/1752) schemas to represent mobile health data in iOS projects.

## Installation

The project can be added to your Xcode project or Swift Package using the [Swift Package Manager](https://github.com/apple/swift-package-manager).

**Xcode:** For an Xcode project, follow the instructions on [adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

**Swift Package:** You can follow the [Swift Package Manager documentation about defining dependencies](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md#defining-dependencies) to add this project as a dependency to your Swift Package.

## Schemas

The following schemas are currently supported by this package:

### IEEE 1752

- [body-posture](https://w3id.org/ieee/ieee-1752-schema/body-posture.json)
- [data-point](https://w3id.org/ieee/ieee-1752-schema/data-point.json)
- [date-time](https://w3id.org/ieee/ieee-1752-schema/date-time.json)
- [descriptive-statistic](https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic.json)
- [descriptive-statistic-denominator](https://w3id.org/ieee/ieee-1752-schema/descriptive-statistic-denominator.json)
- [duration-unit-value](https://w3id.org/ieee/ieee-1752-schema/duration-unit-value.json)
- [duration-unit-value-range](https://w3id.org/ieee/ieee-1752-schema/duration-unit-value-range.json)
- [frequency-unit-value](https://w3id.org/ieee/ieee-1752-schema/frequency-unit-value.json)
- [schema-id](https://w3id.org/ieee/ieee-1752-schema/schema-id.json)
- [header](https://w3id.org/ieee/ieee-1752-schema/header.json)
- [physical-activity](https://w3id.org/ieee/ieee-1752-schema/physical-activity.json)
- [time-frame](https://w3id.org/ieee/ieee-1752-schema/time-frame.json)
- [time-interval](https://w3id.org/ieee/ieee-1752-schema/time-interval.json)
- [total-sleep-time](https://w3id.org/ieee/ieee-1752-schema/total-sleep-time.json)
- [unit-value](https://w3id.org/ieee/ieee-1752-schema/unit-value.json)
- [unit-value-range](https://w3id.org/ieee/ieee-1752-schema/unit-value-range.json)

### Open mHealth (OMH)

- [blood-glucose](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_blood-glucose)
- [blood-pressure](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_blood-pressure)
- [body-fat-percentage](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-fat-percentage)
-[body-height](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-height)
- [body-location](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-location)
- [body-mass-index](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-mass-index)
- [body-temperature](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-temperature)
- [body-weight](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_body-weight)
- [heart-rate](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_heart-rate)
- [oxygen-saturation](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_oxygen-saturation)
-  [part-of-day](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_part-of-day)
- [respiratory-rate](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_respiratory-rate)
- [specimen-source](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_specimen-source)
-  [step-count](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_step-count)
- [temporal-relationship-to-meal](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-meal)
- [temporal-relationship-to-physical-activity](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-physical-activity)
- [temporal-relationship-to-sleep](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-sleep)

## Usage Example

The `OMHModels` package can be used to represent mobile health data in accordance with the above schemas within your iOS application. 

Below is an example using `TotalSleepTime`, although the same instructions apply to any schema in the package.

### Initialization 

To create an instance of the `TotalSleepTime` struct:

```swift
let sleepTime = TotalSleepTime(
    totalSleepTime: DurationUnitValue(value: 8, unit: .hour),
    effectiveTimeFrame: TimeFrame(timeInterval: 
        TimeInterval(
            startDateTime: // Date, 
            endDateTime: // Date
        ),
    isMainSleep: true,
    descriptiveStatistic: .average,
    descriptiveStatisticDenominator: .week
)
```

### Encoding to JSON 

To encode the `TotalSleepTime` instance to JSON:

```swift
let json: String
do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
    
    // Note that both IEEE 1752 and Open mHealth use snake case for its properties when represneted in JSON
    encoder.keyCodingStrategy = .convertToSnakeCase
    
    let data = try encoder.encode(sleepTime)
    json = String(data: jsonData, encoding: .utf8)
} catch {
    print("Error encoding to JSON: \(error)")
}
```

### Decoding from JSON

To decode a JSON string back to a `TotalSleepTime` instance:

```swift
let jsonString = /* your JSON string here */
if let jsonData = jsonString.data(using: .utf8) {
    do {
        let decoder = JSONDecoder()
        let decodedSleepTime = try decoder.decode(TotalSleepTime.self, from: jsonData)
        print(decodedSleepTime)
    } catch {
        print("Error decoding from JSON: \(error)")
    }
}
```

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/OMHModels/tree/main/LICENSES) for more information.

## Notice
This project is not officially endorsed by Open mHealth or IEEE.

## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/OMHModels/tree/main/CONTRIBUTORS.md) for a full list of all OMHModels contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
