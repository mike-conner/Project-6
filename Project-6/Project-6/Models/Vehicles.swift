//
//  Vehicles.swift
//  Project-6
//
//  Created by Mike Conner on 2/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Vehicles: Codable, EntityTypeGroup {
    var results: [Vehicle]
    var next: String?
}

struct Vehicle: Codable {
    let name: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let vehicleClass: String
    let crew: String
}

extension Vehicle {
    var comparableLength: Double {
        get {
            return self.length.toDouble() ?? 0
        }
    }
}
