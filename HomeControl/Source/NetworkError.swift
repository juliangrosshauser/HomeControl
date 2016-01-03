//
//  NetworkError.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 28/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

/// Contains the different errors `NetworkManager` can throw.
///
/// - AuthenticationDataError: Authentication data can't be encoded.
/// - DownloadError: Error while downloading.
/// - FileManagmentError: File can't be created or removed etc.
///
enum NetworkError: String, ErrorType {

    /// Authentication data can't be encoded.
    case AuthenticationDataError = "Authentication data couldn't be encoded"

    /// Error while downloading.
    case DownloadError = "Error while downloading"

    /// File can't be created or removed etc.
    case FileManagmentError = "File couldn't be created or removed"
}
