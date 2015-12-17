//
//  StoreTests.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 16/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import XCTest
@testable import HomeControl

class StoreTests: XCTestCase {

    let store = Store()
    let structureFileFolder = NSBundle(forClass: StoreTests.self).resourceURL!.URLByAppendingPathComponent("StructureFiles")

    func testParsingValidStructureFileDoesntThrow() {
        let validStructureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!
        let expectation = expectationWithDescription("Parsing valid structure file doesn't throw")

        store.parseStructureFile(validStructureFilePath) { result in
            do {
                try result()
                expectation.fulfill()
            } catch {
                XCTFail("Parsing structure file threw error")
            }
        }

        waitForExpectationsWithTimeout(1, handler: nil)
    }

    func testParsingInvalidStructureFileThrows() {
        let invalidStructureFilePath = structureFileFolder.URLByAppendingPathComponent("InvalidStructureFile.xml").path!
        let expectation = expectationWithDescription("Parsing invalid structure file throws")

        store.parseStructureFile(invalidStructureFilePath) { result in
            do {
                try result()
                XCTFail("Parsing invalid structure file didn't threw error")
            } catch {
                expectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(1, handler: nil)
    }
}
