//
//  NetworkError.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 28/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

enum NetworkError: ErrorType {
    case EncodingError
    case DownloadError(NSError)
    case FileError(ErrorType?)
}
