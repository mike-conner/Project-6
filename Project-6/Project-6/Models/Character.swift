//
//  Character.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

class Character {
    let characterName: String
    let dateOfBirth: String
    let homePlanet: String
    let height: Double
    let eyeColor: String
    let hairColor: String
    
    init(characterName: String, dateOfBirth: String, homePlanet: String, height: Double, eyeColor: String, hairColor: String) {
        self.characterName = characterName
        self.dateOfBirth = dateOfBirth
        self.homePlanet = homePlanet
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
    }
}

extension Character {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let characterName = "name"
            static let dateOfBirth = "birth_year"
            static let homePlanet = "homeworld"
            static let height = "height"
            static let eyeColor = "eye_color"
            static let hairColor = "hair_color"
        }
        
        guard let characterName = json[Key.characterName] as? String,
            let dateOfBirth = json[Key.dateOfBirth] as? String,
            let homePlanet = json[Key.homePlanet] as? String,
            let height = json[Key.height] as? Double,
            let eyeColor = json[Key.eyeColor] as? String,
            let hairColor = json[Key.hairColor] as? String else { return nil }
        
        self.init(characterName: characterName, dateOfBirth: dateOfBirth, homePlanet: homePlanet, height: height, eyeColor: eyeColor, hairColor: hairColor)        
    }
}



















