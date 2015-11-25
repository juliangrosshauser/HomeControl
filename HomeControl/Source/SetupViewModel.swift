//
//  SetupViewModel.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import ReactiveCocoa
import Alamofire

enum SetupError: ErrorType {
    case EncodingError
    case DownloadError(NSError)
    case FileError(ErrorType?)
}

class SetupViewModel {

    //MARK: Properties

    let serverAddress = MutableProperty("")
    let username = MutableProperty("")
    let password = MutableProperty("")
    let loadButtonEnabled = MutableProperty(false)
    var downloadAction: Action<Void, String, SetupError>!
    let loxoneManager = LoxoneManager()

    //MARK: Initialization

    init() {
        loadButtonEnabled <~ combineLatest(serverAddress.producer, username.producer, password.producer).map { (serverAddressText, usernameText, passwordText) in
            if serverAddressText.isEmpty || usernameText.isEmpty || passwordText.isEmpty { return false }
            return true
        }

        downloadAction = Action(enabledIf: loadButtonEnabled) { [unowned self] in
            self.loxoneManager.downloadStructureFile(serverAddress: self.serverAddress.value, username: self.username.value, password: self.password.value)
        }
    }
}
