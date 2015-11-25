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

    //MARK: Initialization

    init() {
        loadButtonEnabled <~ combineLatest(serverAddress.producer, username.producer, password.producer).map { (serverAddressText, usernameText, passwordText) in
            if serverAddressText.isEmpty || usernameText.isEmpty || passwordText.isEmpty { return false }
            return true
        }

        downloadAction = Action(enabledIf: loadButtonEnabled) { [unowned self] in
            self.downloadStructureFile()
        }
    }

    //MARK: Download Structure File

    private func downloadStructureFile() -> SignalProducer<String, SetupError> {
        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first,
            structureFilePath = NSURL.fileURLWithPath(documentDirectory).URLByAppendingPathComponent("LoxAPP2.xml").path else {
                return SignalProducer(error: .FileError(nil))
        }

        let fileManager = NSFileManager.defaultManager()

        if fileManager.fileExistsAtPath(structureFilePath) {
            do {
                try fileManager.removeItemAtPath(structureFilePath)
            } catch {
                return SignalProducer(error: .FileError(error))
            }
        }

        guard let encodedServerAddress = serverAddress.value.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()),
                  credentialData = "\(username.value):\(password.value)".dataUsingEncoding(NSUTF8StringEncoding) else {
                return SignalProducer(error: .EncodingError)
        }

        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        let url = "http://\(encodedServerAddress)/data/LoxAPP2.xml"
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]

        return SignalProducer { observer, _ in
            download(.GET, url, headers: headers, destination: destination).response { _, _, _, error in
                if let error = error {
                    observer.sendFailed(.DownloadError(error))
                }

                observer.sendNext(structureFilePath)
                observer.sendCompleted()
            }
        }
    }
}
