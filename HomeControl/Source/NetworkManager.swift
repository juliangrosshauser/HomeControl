//
//  NetworkManager.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 26/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation
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

    /// Downloads structure file from server.
    ///
    /// - Parameters:
    ///     - authenticationData: Contains all necessary authentication data.
    ///     - completionHandler: This closure will be called after downloading is completed.
    ///
    /// - Throws: Parameter of `completionHandler` throws `NetworkError`.
    ///
    /// - Returns: `Void`
    ///
    /// - Note: The parameter of the `completionHandler` closure is itself a closure that either
    /// returns the path to the downloaded structure file or throws.
    ///
    /// - SeeAlso: Take a look at the documentation of `Store.parseStructureFile(_:completionHandler:)`
    /// for a usage example of the `completionHandler` parameter.
    ///
    func downloadStructureFile(authenticationData: AuthenticationData, completionHandler: (() throws -> String) -> ()) {
        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first,
                  structureFilePath = NSURL.fileURLWithPath(documentDirectory).URLByAppendingPathComponent(NSString(string: Endpoint.StructureFile.rawValue).lastPathComponent).path else {
                    completionHandler { throw NetworkError.FileError(nil) }
                    return
        }

        let fileManager = NSFileManager.defaultManager()

        if fileManager.fileExistsAtPath(structureFilePath) {
            do {
                try fileManager.removeItemAtPath(structureFilePath)
            } catch {
                completionHandler { throw NetworkError.FileError(error) }
                return
            }
        }

        guard let encodedServerAddress = authenticationData.serverAddress.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()),
            credentialData = "\(authenticationData.username):\(authenticationData.password)".dataUsingEncoding(NSUTF8StringEncoding) else {
                completionHandler { throw NetworkError.EncodingError }
                return
        }

        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        let url = "http://\(encodedServerAddress)/\(Endpoint.StructureFile)"
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]

        download(.GET, url, headers: headers, destination: destination).response { _, _, _, error in
            if let error = error {
                completionHandler { throw NetworkError.DownloadError(error) }
                return
            }

            completionHandler { structureFilePath }
        }
    }
}
