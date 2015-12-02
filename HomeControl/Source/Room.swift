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
    let lights: [Light]?
    let blinds: [Blind]?
    let consumers: [Consumer]?

    //MARK: Initialization

    init(id: UInt, name: String) {
        self.id = id
        self.name = name
        lights = nil
        blinds = nil
        consumers = nil
    }
}
