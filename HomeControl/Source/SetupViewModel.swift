//
//  SetupViewModel.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

/// Abstracts `SetupController`s state and behavior.
class SetupViewModel {

    //MARK: Class Properties

    /// Notification name - used to signal that the load button needs to be enabled/disabled.
    static let LoadButtonStatusChanged = "HomeControlLoadButtonStatusChanged"

    /// Dictionary key - used in `userInfo` dictionary of `LoadButtonStatusChanged` notifications.
    static let LoadButtonEnabledKey = "HomeControlLoadButtonEnabledKey"

    //MARK: Properties

    /// Text of server address text field.
    private(set) var serverAddress = ""

    /// Text of username text field.
    private(set) var username = ""

    /// Text of password text field.
    private(set) var password = ""

    /// `true` iff load button is enabled.
    private(set) var loadButtonEnabled = false {
        didSet {
            guard loadButtonEnabled != oldValue else {
                return
            }

            notificationCenter.postNotificationName(SetupViewModel.LoadButtonStatusChanged, object: self, userInfo: [SetupViewModel.LoadButtonEnabledKey: loadButtonEnabled])
        }
    }

    /// `NetworkManager` instance.
    private let networkManager: NetworkManager

    /// `StructureFileParser` instance.
    private let structureFileParser: StructureFileParser

    /// `Store` instance.
    private let store: Store

    /// Default notification center.
    private let notificationCenter = NSNotificationCenter.defaultCenter()

    //MARK: Initialization

    /// Construct `SetupViewModel` using specific `NetworkManager`, `StructureFileParser` and `Store` instances.
    init(networkManager: NetworkManager = NetworkManager(), structureFileParser: StructureFileParser = StructureFileParser(), store: Store = Store()) {
        self.networkManager = networkManager
        self.structureFileParser = structureFileParser
        self.store = store
    }

    //MARK: Text Field Actions

    /// Called when text field has changed.
    ///
    /// - Parameter textField: Text field that has changed.
    ///
    /// - Returns: `Void`
    ///
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
        loadButtonEnabled = ![serverAddress, username, password].containsEmptyElement
    }
}
