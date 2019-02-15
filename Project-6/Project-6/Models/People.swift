//
//  People.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct People: Codable, EntityTypeGroup {
    var results: [Person]
    var next: String?
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
    var comparableHeight: Double {
        get {
            return self.height.toDouble() ?? 0
        }
    }
}

extension Person {
    static func == (lhs: Person , rhs: Planet) -> Bool {
        return lhs.homeworld == rhs.url
    }

}

extension Person {
    func getPlanetName(personUrl: String, planets: Planets?) -> String? {
        var name: String?
        var index = 0
        while index < planets?.results.count ?? 0 {
            if planets?.results[index].url == personUrl {
                name = planets?.results[index].name
                return name
            } else { index += 1 }
        }
        return nil
    }
}







