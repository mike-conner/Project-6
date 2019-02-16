//
//  SWAPIClientPlanetExtension.swift
//  Project-6
//
//  Created by Mike Conner on 2/16/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

extension SWAPIClient {
    func getListOfPlanets(page: Int, completionHandler completion: @escaping (Planets?, Error?) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let url = URL(string: "https://swapi.co/api/planets/?page=\(page)") else {
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
                            let entities = try self.decoder.decode(Planets.self, from: data)
                            completion(entities, nil)
                        } catch _ {
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
