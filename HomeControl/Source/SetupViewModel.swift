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

    //MARK: Download Structure File

    private func downloadStructureFile() -> SignalProducer<Void, SetupError> {
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

                observer.sendCompleted()
            }
        }
    }
}
