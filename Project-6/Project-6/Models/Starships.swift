//
//  StarShips.swift
//  Project-6
//
//  Created by Mike Conner on 2/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Starships: Codable {
    let results: [Starship]
    let next: String?
}

struct Starship: Codable {
    let name: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let starshipClass: String
    let crew: String
}

