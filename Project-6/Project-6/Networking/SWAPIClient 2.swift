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
    
    func getEntityList(entityType: EntityType, page: Int, completionHandler completion: @escaping (EntityCollection?, Error?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "https://swapi.co/api/\(entityType.rawValue)/?page=\(page)") else {
            completion(nil, SWAPIError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SWAPIError.responseUnsuccessful)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let entities = try self.decoder.decode(EntityCollection.self, from: data)
                                completion(entities, nil)
                            }
                        catch _ {
                            completion(nil, SWAPIError.jsonParsingFailure)
                        }
                    } else {
                        completion(nil, SWAPIError.badRequestResponse)
                    }
                } else if error != nil {
                    completion(nil, SWAPIError.requestFailed)
                }
            }
        }
        task.resume()
    }
}
