//
//  SWAPIClient.swift
//  Project-6
//
//  Created by Mike Conner on 2/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

class SWAPIClient {
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: .default)
    }
}
