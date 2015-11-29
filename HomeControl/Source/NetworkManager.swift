//
//  NetworkManager.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 26/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Alamofire

class NetworkManager {

    //MARK: Endpoint

    private enum Endpoint: String, CustomStringConvertible {
        case StructureFile = "data/LoxAPP2.xml"

        //MARK: CustomStringConvertible

        var description: String {
            return rawValue
        }
    }

    //MARK: Download Structure File

    func downloadStructureFile(serverAddress serverAddress: String, username: String, password: String) -> SignalProducer<String, NetworkError> {
        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first,
                  structureFilePath = NSURL.fileURLWithPath(documentDirectory).URLByAppendingPathComponent(NSString(string: Endpoint.StructureFile.rawValue).lastPathComponent).path else {
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

        guard let encodedServerAddress = serverAddress.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()),
            credentialData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding) else {
                return SignalProducer(error: .EncodingError)
        }

        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        let url = "http://\(encodedServerAddress)/\(Endpoint.StructureFile)"
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
