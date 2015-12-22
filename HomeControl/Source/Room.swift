//
//  Room.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//


/// Represents a room containing lights, blinds and consumers.
struct Room {

    //MARK: Properties

    /// Room ID.
    let id: UInt
    
    /// Room name.
    let name: String
    
    /// Lights.
    var lights: [Light]?
    
    /// Blinds.
    var blinds: [Blind]?
    
    /// Consumers.
    var consumers: [Consumer]?

    //MARK: Initialization

    /// Construct a `Room` without any lights, blinds or consumers.
    init(id: UInt, name: String) {
        self.id = id
        self.name = name
    }
}
