//
//  Store.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 30/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import ReactiveCocoa
import SWXMLHash

enum StoreError: ErrorType {
    case NetworkError(ErrorType?)
    case ReadError(ErrorType)
}

class Store {

    func parseStructureFile(path: String) -> SignalProducer<[Room], StoreError> {
        let structureFileContent: String

        do {
            structureFileContent = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        } catch {
            return SignalProducer(error: .ReadError(error))
        }

        let structureFile = SWXMLHash.parse(structureFileContent)
        var rooms = [Room]()

        for room in structureFile["LoxLIVE"]["Rooms"]["Room"] {
            if let idString = room.element?.attributes["n"], id = UInt(idString), name = room.element?.attributes["name"] {
                rooms.append(Room(id: id, name: name))
            }
        }

        return SignalProducer(value: rooms)
    }
}
