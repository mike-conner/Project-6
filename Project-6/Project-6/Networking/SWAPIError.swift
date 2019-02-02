//
//  SWAPIError.swift
//  Project-6
//
//  Created by Mike Conner on 2/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

enum SWAPIError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidUrl
}
