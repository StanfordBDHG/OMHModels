//
// This source file is part of the OMHModels open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import Testing
import Foundation

@Suite("Header Tests")
struct HeaderTests {
    @Test("Default initialization")
    func testDefaultInit() {
        let dateTime = DateTime(date: .now)
        let schemaId = SchemaId(
            namespace: .ieee,
            name: "test-schema",
            version: "1.0"
        )
        
        let header = Header(sourceCreationDateTime: dateTime, schemaId: schemaId)
        
        #expect(!header.uuid.isEmpty)
        #expect(header.sourceCreationDateTime == dateTime)
        #expect(header.schemaId == schemaId)
        #expect(header.modality == nil)
        #expect(header.acquisitionRate == nil)
        #expect(header.externalDatasheets.isEmpty)
    }
    
    @Test("Full initialization")
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
            timeWindow: TimeWindow.duration(DurationUnitValue(unit: TimeUnit.h, value: 1.0)),
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
        
        #expect(header.uuid == uuid)
        #expect(header.sourceCreationDateTime == dateTime)
        #expect(header.schemaId == schemaId)
        #expect(header.modality == modality)
        #expect(header.acquisitionRate == acquisitionRate)
        #expect(header.externalDatasheets == [externalDatasheet])
    }
}
