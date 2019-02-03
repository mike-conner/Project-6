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
    
    func getEntityList(entityType: EntityType, completionHandler completion: @escaping (People?, Vehicles?, Starships?, Planets?, Error?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let base = URL(string: "https://swapi.co/api/")
        
        guard let url = URL(string: entityType.rawValue, relativeTo: base) else {
            completion(nil, nil, nil, nil, SWAPIError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, nil, nil, nil, SWAPIError.requestFailed)
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
                        } catch let error {
                            completion(nil, nil, nil, nil, error)
                        }
                    } else {
                        completion(nil, nil, nil, nil, SWAPIError.responseUnsuccessful(statusCode: httpResponse.statusCode))
                    }
                } else if let error = error {
                    completion(nil, nil, nil, nil, error)
                }
            }
        }
        task.resume()
    }
}
