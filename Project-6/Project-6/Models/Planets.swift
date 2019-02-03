//
//  Planets.swift
//  Project-6
//
//  Created by Mike Conner on 2/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Planets: Codable {
    let results: [Planet]
}

struct Planet: Codable, Equatable {
    let name: String
    let url: String
}

extension Planet {
    static func == (lhs: Person, rhs: Planet) -> Bool {
        return lhs.homeworld == rhs.url
    }}
