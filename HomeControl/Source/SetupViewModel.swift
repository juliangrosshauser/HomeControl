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

    //MARK: Enumerations

    enum NotificationName: String, PrefixedStringConstant {

        /// Used to signal that the load button needs to be enabled/disabled.
        case LoadButtonStatusChanged

        /// Used to send `loadStructureFile()` return values.
        case LoadStructureFileCompleted
    }

    enum UserInfoKey: String {

        /// Used in `userInfo` dictionary of `NotificationName.LoadButtonStatusChanged` notifications.
        case LoadButtonEnabled = "loadButtonEnabled"

        /// Used in `userInfo` dictionary of `NotificationName.LoadStructureFileCompleted` notifications.
        case LoadStructureFileManagedRooms = "managedRooms"

        /// Used in `userInfo` dictionary of `NotificationName.LoadStructureFileCompleted` notifications.
        case LoadStructureFileError = "error"
    }

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

            notificationCenter.postNotificationName(NotificationName.LoadButtonStatusChanged.description, object: self, userInfo: [UserInfoKey.LoadButtonEnabled.rawValue: loadButtonEnabled])
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

    func loadStructureFile() {
        guard let authenticationData = AuthenticationData(serverAddress: serverAddress, username: username, password: password) else {
            self.notificationCenter.postNotificationName(NotificationName.LoadStructureFileCompleted.description, object: self, userInfo: [UserInfoKey.LoadStructureFileError.rawValue: "Invalid authentication data"])
            return
        }

        networkManager.downloadStructureFile(authenticationData) { [unowned self] result in
            do {
                let structureFilePath = try result()
                let rooms = try self.structureFileParser.parse(structureFilePath)

                // If parsing the structure file was successfull we can be sure that the authentication data is valid
                // and therefore should be saved in the keychain. To ignore all Locksmith errors, a thrown error is
                // converted to an optional value and then never used.
                _ = try? authenticationData.save()

                self.store.context.performChanges {
                    let managedRooms = rooms.map {
                        ManagedRoom.insert($0, intoContext: self.store.context)
                    }

                    self.notificationCenter.postNotificationName(NotificationName.LoadStructureFileCompleted.description, object: self, userInfo: [UserInfoKey.LoadStructureFileManagedRooms.rawValue: managedRooms])
                }
            } catch let error as NetworkError {
                self.notificationCenter.postNotificationName(NotificationName.LoadStructureFileCompleted.description, object: self, userInfo: [UserInfoKey.LoadStructureFileError.rawValue: error.rawValue])
            } catch let error as StructureFileParserError {
                self.notificationCenter.postNotificationName(NotificationName.LoadStructureFileCompleted.description, object: self, userInfo: [UserInfoKey.LoadStructureFileError.rawValue: error.rawValue])
            } catch {
                self.notificationCenter.postNotificationName(NotificationName.LoadStructureFileCompleted.description, object: self, userInfo: [UserInfoKey.LoadStructureFileError.rawValue: "Error while loading structure file"])
            }
        }
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
