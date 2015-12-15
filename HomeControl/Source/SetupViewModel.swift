//
//  SetupViewModel.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Alamofire

class SetupViewModel {

    //MARK: Class Properties

    static let LoadButtonStatusChanged = "HomeControlLoadButtonStatusChanged"
    static let LoadButtonEnabledKey = "HomeControlLoadButtonEnabledKey"

    //MARK: Properties

    private(set) var serverAddress = ""
    private(set) var username = ""
    private(set) var password = ""

    private(set) var loadButtonEnabled = false {
        didSet {
            guard loadButtonEnabled != oldValue else {
                return
            }

            notificationCenter.postNotificationName(SetupViewModel.LoadButtonStatusChanged, object: self, userInfo: [SetupViewModel.LoadButtonEnabledKey: loadButtonEnabled])
        }
    }

    private let networkManager: NetworkManager
    private let store: Store
    private let notificationCenter = NSNotificationCenter.defaultCenter()

    //MARK: Initialization

    init(networkManager: NetworkManager = NetworkManager(), store: Store = Store()) {
        self.networkManager = networkManager
        self.store = store
    }

    //MARK: Text Field Actions

    @objc
    private func textFieldDidChange(textField: SetupTextField) {
        guard let text = textField.text else {
            return
        }

        switch textField.asset {
        case .Server:
            serverAddress = text
        case .User:
            username = text
        case .Lock:
            password = text
        default:
            return
        }

        // Load button is enabled iff all text fields contain text
        loadButtonEnabled = [serverAddress, username, password].map({
            !$0.isEmpty
        }).reduce(true) { (allTextFieldContainText, textFieldContainsText) in
            allTextFieldContainText && textFieldContainsText
        }
    }
}
