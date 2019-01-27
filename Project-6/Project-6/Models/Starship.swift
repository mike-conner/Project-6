//
//  Starship.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

class Starship {
    let name: String
    let make: [String]
    let cost: Int
    let length: Double
    let starshipClass: String
    let crew: Int
    
    init(name: String, make: [String], cost: Int, length: Double, starshipClass: String, crew: Int) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
    }
}

extension Starship {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let name = "name"
            static let make = "manufacturer"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let starshipClass = "starship_class"
            static let crew = "crew"
        }
        
        guard let name = json[Key.name] as? String,
            let make = json[Key.make] as? [String],
            let cost = json[Key.cost] as? Int,
            let length = json[Key.length] as? Double,
            let starshipClass = json[Key.starshipClass] as? String,
            let crew =  json[Key.crew] as? Int else { return nil }
        
        self.init(name: name, make: make, cost: cost, length: length, starshipClass: starshipClass, crew: crew)
    }
}

