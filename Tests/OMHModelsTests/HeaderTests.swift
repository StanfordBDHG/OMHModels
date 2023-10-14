//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest

class HeaderTests: XCTestCase {
    func testDefaultInit() {
        let dateTime = DateTime(date: .now)
        let schemaId = SchemaId(
            namespace: .ieee,
            name: "test-schema",
            version: "1.0"
        )
        
        let header = Header(sourceCreationDateTime: dateTime, schemaId: schemaId)
        
        XCTAssertNotNil(header.uuid)
        XCTAssertEqual(header.sourceCreationDateTime, dateTime)
        XCTAssertEqual(header.schemaId, schemaId)
        XCTAssertNil(header.modality)
        XCTAssertNil(header.acquisitionRate)
        XCTAssertTrue(header.externalDatasheets.isEmpty)
    }
    
    func testFullInit() {
        let uuid = UUID().uuidString
        let dateTime = DateTime(date: .now)
        let schemaId = SchemaId(
            namespace: .ieee,
            name: "test-schema",
            version: "1.0"
        )
        let modality = Modality.selfReported
        let acquisitionRate = FrequencyUnitValue(
            timeWindow: DurationUnitValue(
                unit: TimeUnit.h,
                value: 1
            ),
            numberOfTimes: 10
        )
        let externalDatasheet = ExternalDataSheet(datasheetReference: "reference")
        
        let header = Header(
            uuid: uuid,
            sourceCreationDateTime: dateTime,
            schemaId: schemaId,
            modality: modality,
            acquisitionRate: acquisitionRate,
            externalDatasheets: [externalDatasheet]
        )
        
        XCTAssertEqual(header.uuid, uuid)
        XCTAssertEqual(header.sourceCreationDateTime, dateTime)
        XCTAssertEqual(header.schemaId, schemaId)
        XCTAssertEqual(header.modality, modality)
        XCTAssertEqual(header.acquisitionRate, acquisitionRate)
        XCTAssertEqual(header.externalDatasheets, [externalDatasheet])
    }
}
