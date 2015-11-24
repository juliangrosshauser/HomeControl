//
//  SetupViewModel.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import ReactiveCocoa

enum SetupError: ErrorType {
    case EncodingError
    case DownloadError(NSError)
}

class SetupViewModel {

    //MARK: Properties

    let serverAddress = MutableProperty("")
    let username = MutableProperty("")
    let password = MutableProperty("")
    let loadButtonEnabled = MutableProperty(false)

    //MARK: Initialization

    init() {
        loadButtonEnabled <~ combineLatest(serverAddress.producer, username.producer, password.producer).map { (serverAddressText, usernameText, passwordText) in
            if serverAddressText.isEmpty || usernameText.isEmpty || passwordText.isEmpty { return false }
            return true
        }
    }
}
