//
//  Consumer.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Consumer accessory.
struct Consumer: Accessory {

    //MARK: Properties

    /// Consumer name.
    let name: String
    
    /// Action ID of consumer. Can be used to turn on/off consumer.
    let actionID: String
}
