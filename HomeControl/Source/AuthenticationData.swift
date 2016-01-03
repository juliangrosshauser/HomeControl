//
//  AuthenticationData.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 01/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Locksmith

/// Contains all data necessary to authenticate a user at the server.
struct AuthenticationData {

    //MARK: Properties

    /// Address of server.
    let serverAddress: String

    /// Name that identifies user.
    let username: String

    /// Password of user.
    let password: String

    //MARK: Initialization

    /// Construct `AuthenticationData` containing server address, username and password.
    /// The result is `nil` iff any parameter contains no characters.
    init?(serverAddress: String, username: String, password: String) {
        if [serverAddress, username, password].containsEmptyElement {
            return nil
        }
        
        self.serverAddress = serverAddress
        self.username = username
        self.password = password
    }
}

//MARK: GenericPasswordSecureStorable

extension AuthenticationData: GenericPasswordSecureStorable {

    /// The service that the authentication data is saved under in the keychain.
    var service: String {
        return "HomeControl"
    }

    /// The account that identifies the authentication data in the keychain.
    var account: String {
        return username
    }
}

//MARK: CreateableSecureStorable

extension AuthenticationData: CreateableSecureStorable {

    /// Data that's saved in the keychain.
    var data: [String: AnyObject] {
        return ["password": password, "serverAddress": serverAddress]
    }
}

//MARK: ReadableSecureStorable

extension AuthenticationData: ReadableSecureStorable {}

//MARK: DeleteableSecureStorable

extension AuthenticationData: DeleteableSecureStorable {}
