//
//  Light.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Light accessory.
struct Light: Accessory {

    //MARK: Properties

    /// Light name.
    let name: String
    
    /// Action ID of light. Can be used to turn on/off light.
    let actionID: String
}
