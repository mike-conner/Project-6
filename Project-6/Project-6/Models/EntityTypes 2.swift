//
//  EntityTypes.swift
//  Project-6
//
//  Created by Mike Conner on 2/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

// List the different possible Entity collection types.
enum EntityType: String {
    case people
    case vehicles
    case starships
    case planets
}

struct EntityCollection: Codable {
    var peopleResults: [People]
    var vehicleResults: [Vehicle]
    var starshipResults: [Starship]
    var planetResults: [Planet]
}
