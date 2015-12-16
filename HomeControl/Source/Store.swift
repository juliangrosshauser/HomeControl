//
//  Store.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 30/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import SWXMLHash

enum StoreError: ErrorType {
    case ReadError(ErrorType)
}

class Store {

    func parseStructureFile(path: String, completionHandler: (() throws -> [Room]) -> ()) {
        let structureFileContent: String

        do {
            structureFileContent = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        } catch {
            completionHandler { throw StoreError.ReadError(error) }
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
