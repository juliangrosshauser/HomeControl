//
//  NetworkManager.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 26/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation
import Alamofire

/// Handles all network tasks.
class NetworkManager {

    //MARK: Endpoint

    /// Server endpoints.
    ///
    /// - StructureFile: Points to structure file.
    ///
    private enum Endpoint: String, CustomStringConvertible {

        /// Points to structure file.
        case StructureFile = "data/LoxAPP2.xml"

        //MARK: CustomStringConvertible

        /// Returns endpoint paths.
        var description: String {
            return rawValue
        }
    }

    //MARK: Download Structure File

    /// Downloads structure file from server.
    ///
    /// - Parameters:
    ///     - authenticationData: Contains all necessary data to authenticate a user at the server.
    ///     - completionHandler: This closure will be called after downloading is completed.
    ///
    /// - Throws: Parameter of `completionHandler` throws `NetworkError`.
    ///
    /// - Returns: `Void`
    ///
    /// - Note: The parameter of the `completionHandler` closure is itself a closure that either
    /// returns the path to the downloaded structure file or throws.
    ///
    /// This example shows how to use `completionHandler`:
    ///
    ///         let networkManager = NetworkManager()
    ///         networkManager.downloadStructureFile(authenticationData) { result in
    ///             do {
    ///                 let structureFilePath = try result()
    ///                 // Do something with `structureFilePath`
    ///             } catch {
    ///                 // Handle `NetworkError`
    ///             }
    ///         }
    ///
    func downloadStructureFile(authenticationData: AuthenticationData, completionHandler: (() throws -> String) -> ()) {
        // Create structure file path in document directory.
        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first,
                  structureFilePath = NSURL.fileURLWithPath(documentDirectory).URLByAppendingPathComponent(NSString(string: Endpoint.StructureFile.rawValue).lastPathComponent).path else {
                    completionHandler { throw NetworkError.FileManagmentError }
                    return
        }

        // Remove existing structure file.
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(structureFilePath) {
            do {
                try fileManager.removeItemAtPath(structureFilePath)
            } catch {
                completionHandler { throw NetworkError.FileManagmentError }
                return
            }
        }

        // Encode authentication data.
        guard let encodedServerAddress = authenticationData.serverAddress.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()),
            credentialData = "\(authenticationData.username):\(authenticationData.password)".dataUsingEncoding(NSUTF8StringEncoding) else {
                completionHandler { throw NetworkError.AuthenticationDataError }
                return
        }

        // Set up authorization header and download structure file into document directory.
        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        let url = "http://\(encodedServerAddress)/\(Endpoint.StructureFile)"
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]

        download(.GET, url, headers: headers, destination: destination).response { _, response, _, error in
            guard response?.statusCode == 200 && error == nil else {
                // Wrong password.
                if response?.statusCode == 401 {
                    completionHandler { throw NetworkError.WrongPassword }
                    return
                }

                // Wrong username.
                if response?.statusCode == 403 {
                    completionHandler { throw NetworkError.WrongUsername }
                    return
                }

                if error?.code == NSURLErrorTimedOut {
                    completionHandler { throw NetworkError.TimeOut }
                    return
                }

                completionHandler { throw NetworkError.DownloadError }
                return
            }

            completionHandler { structureFilePath }
        }
    }
}
