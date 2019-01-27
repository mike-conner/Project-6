//
//  Stub.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Stub {
    static var character: Character {
        return Character(characterName: "mike conner", dateOfBirth: "today", homePlanet: "earth", height: 71.5, eyeColor: "green", hairColor: "bald")
    }
    
    static var vehicle: Vehicle {
        return Vehicle(name: "car", make: ["chevy"], cost: 100, length: 3500.0, vehicleClass: "wheeled", crew: 2)
    }
    
    static var starship: Starship {
        return Starship(name: "plane", make: ["boeing"], cost: 100000, length: 5000.0, starshipClass: "wings", crew: 40)
    }
    
}




