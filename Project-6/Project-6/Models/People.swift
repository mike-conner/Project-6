//
//  People.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct People: Codable {
    let results: [Person]
}

struct Person: Codable, Equatable {
    let name: String
    let birthYear: String
    let homeworld: String
    let height: String
    let eyeColor: String
    let hairColor: String
}

extension Person {
    static func == (lhs: Person , rhs: Planet) -> Bool {
        return lhs.homeworld == rhs.url
    }
}













