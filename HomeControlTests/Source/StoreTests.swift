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
        let expectation = expectationWithDescription("Parsing valid structure file doesn't throw")

        store.parseStructureFile(validStructureFilePath) { result in
            do {
                try result()
                expectation.fulfill()
            } catch {
                XCTFail("Parsing structure file threw error")
            }
        }

        waitForExpectationsWithTimeout(expectationTimeout, handler: nil)
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

        waitForExpectationsWithTimeout(expectationTimeout, handler: nil)
    }

    func testParsingReturnsRooms() {
        let structureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!
        let expectation = expectationWithDescription("Parsing structure file returns rooms")

        store.parseStructureFile(structureFilePath) { result in
            do {
                let rooms = try result()
                if rooms.count == 5 {
                    expectation.fulfill()
                }
            } catch {
                XCTFail("Parsing structure file threw error")
            }
        }

        waitForExpectationsWithTimeout(expectationTimeout, handler: nil)
    }

    func testParsingReturnsLights() {
        let structureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!
        let expectation = expectationWithDescription("Parsing structure file returns lights")

        store.parseStructureFile(structureFilePath) { result in
            do {
                let rooms = try result()
                var lightExpectations = 0

                if let lights = rooms.first?.lights where lights.count == 2 {
                    lightExpectations += 1
                }

                // Rooms with IDs from 2 to 4 contain only one light.
                for room in rooms[1...3] {
                    if let lights = room.lights where lights.count == 1 {
                        lightExpectations += 1
                    }
                }

                // Four rooms should contain lights.
                if lightExpectations == 4 {
                    expectation.fulfill()
                }
            } catch {
                XCTFail("Parsing structure file threw error")
            }
        }

        waitForExpectationsWithTimeout(expectationTimeout, handler: nil)
    }
}
