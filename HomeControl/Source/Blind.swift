//
//  Blind.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Blind accessory.
public struct Blind: Accessory {

    //MARK: Properties

    /// Blind name.
    public let name: String
    
    /// Action ID of blind. Can be used to raise/pull down blind.
    public let actionID: String

    //MARK: Initialization

    /// Construct a `Blind` with a name and action ID.
    public init(name: String, actionID: String) {
        self.name = name
        self.actionID = actionID
    }
}
