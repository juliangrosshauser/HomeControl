//
//  Store.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 30/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import SWXMLHash

class Store {

    /// Parses a structure file.
    ///
    /// - Parameters:
    ///     - path: Structure file path.
    ///     - completionHandler: This closure will be called after parsing is completed.
    ///
    /// - Throws: Parameter of `completionHandler` throws `StoreError`.
    ///
    /// - Returns: `Void`
    ///
    /// - Note: The parameter of the `completionHandler` closure is itself a closure that either returns `[Room]` or throws.
    /// 
    /// This example shows how to use `completionHandler`:
    ///
    ///         let store = Store()
    ///         store.parseStructureFile(structureFilePath) { result in
    ///             let rooms: [Room]
    ///
    ///             do {
    ///                 rooms = try result()
    ///             } catch {
    ///                 // Handle `StoreError`
    ///             }
    ///
    ///             // Do something with `rooms`
    ///         }
    ///
    func parseStructureFile(path: String, completionHandler: (() throws -> [Room]) -> ()) {
        let structureFileContent: String

        do {
            structureFileContent = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        } catch {
            completionHandler { throw StoreError.ReadError }
            return
        }

        let structureFile = SWXMLHash.parse(structureFileContent)
        var rooms = [Room]()

        for room in structureFile["LoxLIVE"]["Rooms"]["Room"] {
            if let idString = room.element?.attributes["n"], id = UInt(idString), name = room.element?.attributes["name"] {
                rooms.append(Room(id: id, name: name))
            }
        }

        completionHandler { rooms }
    }
}
