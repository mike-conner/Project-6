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
    
    func getEntityList(entityType: EntityType, page: Int, completionHandler completion: @escaping (People?, Vehicles?, Starships?, Planets?, Error?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "https://swapi.co/api/\(entityType.rawValue)/?page=\(page)") else {
            completion(nil, nil, nil, nil, SWAPIError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, nil, nil, nil, SWAPIError.responseUnsuccessful)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            switch entityType {
                            case .people:
                                let entities = try self.decoder.decode(People.self, from: data)
                                completion(entities, nil, nil, nil, nil)
                            case .vehicles:
                                let entities = try self.decoder.decode(Vehicles.self, from: data)
                                completion(nil, entities, nil, nil, nil)
                            case .starships:
                                let entities = try self.decoder.decode(Starships.self, from: data)
                                completion(nil, nil, entities, nil, nil)
                            case .planets:
                                let entities = try self.decoder.decode(Planets.self, from: data)
                                completion(nil, nil, nil, entities, nil)
                            }
                        } catch _ {
                            completion(nil, nil, nil, nil, SWAPIError.jsonParsingFailure)
                        }
                    } else {
                        completion(nil, nil, nil, nil, SWAPIError.badRequestResponse)
                    }
                } else if error != nil {
                    completion(nil, nil, nil, nil, SWAPIError.requestFailed)
                }
            }
        }
        task.resume()
    }
}
