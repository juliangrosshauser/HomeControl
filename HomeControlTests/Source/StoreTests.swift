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
    let expectationTimeout: Double = 1

    func testParsingValidStructureFileDoesntThrow() {
        let validStructureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!

        do {
            try store.parseStructureFile(validStructureFilePath)
        } catch {
            XCTFail("Parsing structure file threw error")
        }
    }

    func testParsingInvalidStructureFileThrows() {
        let invalidStructureFilePath = structureFileFolder.URLByAppendingPathComponent("InvalidStructureFile.xml").path!
        let expectation = expectationWithDescription("Parsing invalid structure file throws")

        do {
            try store.parseStructureFile(invalidStructureFilePath)
            XCTFail("Parsing invalid structure file didn't threw error")
        } catch {
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(expectationTimeout, handler: nil)
    }

    func testParsingReturnsRooms() {
        let structureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!

        do {
            let rooms = try store.parseStructureFile(structureFilePath)
            XCTAssertEqual(rooms.count, 5)
        } catch {
            XCTFail("Parsing structure file threw error")
        }
    }

    func testParsingReturnsLights() {
        let structureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!

        do {
            let rooms = try store.parseStructureFile(structureFilePath)
            XCTAssertEqual(rooms.first?.lights?.count, 2)

            // Rooms with IDs from 2 to 4 contain only one light.
            for room in rooms[1...3] {
                XCTAssertEqual(room.lights?.count, 1)
            }
        } catch {
            XCTFail("Parsing structure file threw error")
        }
    }
}
