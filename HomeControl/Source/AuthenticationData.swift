//
//  AuthenticationData.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 01/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//


/// Contains all data necessary to authenticate a user at the server.
struct AuthenticationData {

    //MARK: Properties

    /// Address of server.
    let serverAddress: String

    /// Name that identifies user.
    let username: String

    /// Password of user.
    let password: String
}
