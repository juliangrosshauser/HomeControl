//
//  StoreSpec.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 12/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Quick
import Nimble
@testable import HomeControl

class StoreSpec: QuickSpec {

    override func spec() {
        describe("Store") {
            var store: Store!
            beforeEach { store = Store() }

            describe("parseStructureFile") {
                let structureFileFolder = NSBundle(forClass: StoreSpec.self).resourceURL!.URLByAppendingPathComponent("StructureFiles")

                context("valid structure file") {
                    let validStructureFilePath = structureFileFolder.URLByAppendingPathComponent("ValidStructureFile.xml").path!

                    it("returns rooms without error") {
                        let signalProducer = store.parseStructureFile(validStructureFilePath)

                        var values = [[Room]]()
                        var error: StoreError?
                        var completed = false

                        signalProducer.start { event in
                            switch event {
                            case let .Next(value):
                                values.append(value)
                            case let .Failed(storeError):
                                error = storeError
                            case .Completed:
                                completed = true
                            default:
                                break
                            }
                        }

                        expect(values.count).to(equal(1))
                        expect(error).to(beNil())
                        expect(completed).to(beTrue())
                    }
                }
            }
        }
    }
}
