//
//  Room.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

struct Room {

    //MARK: Properties

    let id: UInt
    let name: String
    var lights: [Light]?
    var blinds: [Blind]?
    var consumers: [Consumer]?

    //MARK: Initialization

    init(id: UInt, name: String) {
        self.id = id
        self.name = name
    }
}
