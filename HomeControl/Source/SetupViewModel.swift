//
//  SetupViewModel.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import ReactiveCocoa
import Alamofire

class SetupViewModel {

    //MARK: Properties

    let serverAddress = MutableProperty("")
    let username = MutableProperty("")
    let password = MutableProperty("")

    let loadButtonEnabled = MutableProperty(false)
    var downloadAction: Action<Void, String, NetworkError>!

    private let networkManager: NetworkManager
    private let store: Store

    //MARK: Initialization

    init(networkManager: NetworkManager = NetworkManager(), store: Store = Store()) {
        self.networkManager = networkManager
        self.store = store
        
        loadButtonEnabled <~ combineLatest(serverAddress.producer, username.producer, password.producer).map { (serverAddressText, usernameText, passwordText) in
            if serverAddressText.isEmpty || usernameText.isEmpty || passwordText.isEmpty { return false }
            return true
        }

        downloadAction = Action(enabledIf: loadButtonEnabled) { [unowned self] in
            self.networkManager.downloadStructureFile(serverAddress: self.serverAddress.value, username: self.username.value, password: self.password.value)
        }
    }
}
