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
enum NetworkError: ErrorType {

    /// Authentication data can't be encoded.
    case AuthenticationDataError

    /// Error while downloading.
    case DownloadError

    /// File can't be created or removed etc.
    case FileManagmentError
}
