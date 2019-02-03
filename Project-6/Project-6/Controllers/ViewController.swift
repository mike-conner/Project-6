//
//  ViewController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let client = SWAPIClient(configuration: .default)
    
    var entity: EntityType?
    
    var peopleCollectionList: People?
    var vehicleCollectionList: Vehicles?
    var starsthipCollectionList: Starships?
    var planetCollectionList: Planets?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfEntities(entity: .people)
        getListOfEntities(entity: .vehicles)
        getListOfEntities(entity: .starships)
        getListOfEntities(entity: .planets)
    }

    
    @IBAction func starWarsObjectSelection (_ sender: UIButton) {
        switch sender.tag {
        case 0:
            entity = .people
        case 1:
            entity = .vehicles
        case 2:
            entity = .starships
        default:
            break
        }
        performSegue(withIdentifier: "starWarSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let destVC = nav.topViewController as? SearchResultsController {
            destVC.entity = entity
            destVC.peopleCollectionList = peopleCollectionList
            destVC.vehicleCollectionList = vehicleCollectionList
            destVC.starshipCollectionList = starsthipCollectionList
            destVC.planetCollectionList = planetCollectionList
        }
    }
    
    func getListOfEntities(entity: EntityType) {
        DispatchQueue.main.async {
            self.client.getEntityList(entityType: entity) { people, vehicles, starships, planets, error in
                if let people = people {
                    self.peopleCollectionList = people
                }
                if let vehicles = vehicles {
                    self.vehicleCollectionList = vehicles
                }
                if let starships = starships {
                    self.starsthipCollectionList = starships
                }
                if let planets = planets {
                    self.planetCollectionList = planets
                }
            }
        }
    }
}

