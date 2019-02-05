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
    var page = 1                                            // Need to create page variable for each entity and update getListOfEntities() accordingly!!!!
    
    var peopleCollectionList: People?
    var vehicleCollectionList: Vehicles?
    var starsthipCollectionList: Starships?
    var planetCollectionList: Planets?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfEntities(entity: .people, page: page)
        getListOfEntities(entity: .vehicles, page: page)
        getListOfEntities(entity: .starships, page: page)
        getListOfEntities(entity: .planets, page: page)
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
    
    func getListOfEntities(entity: EntityType, page: Int) {
        DispatchQueue.main.async {
            self.client.getEntityList(entityType: entity, page: self.page) { people, vehicles, starships, planets, error in
                if let people = people {
                    if self.peopleCollectionList?.results == nil {
                        self.peopleCollectionList = people
                        self.page = self.page + 1
                    } else {
                        self.peopleCollectionList?.results.append(contentsOf: people.results)
                        self.page = self.page + 1
                    }
                    if people.next != nil {
                        self.getListOfEntities(entity: .people, page: self.page)
                    } 
                }
                if let vehicles = vehicles {
                    if self.vehicleCollectionList?.results == nil {
                        self.vehicleCollectionList = vehicles
                        self.page = self.page + 1
                    } else {
                        self.vehicleCollectionList?.results.append(contentsOf: vehicles.results)
                        self.page = self.page + 1
                    }
                    if vehicles.next != nil {
                        self.getListOfEntities(entity: .vehicles, page: self.page)
                    }
                }
                if let starships = starships {
                    if self.starsthipCollectionList?.results == nil {
                        self.starsthipCollectionList = starships
                        self.page = self.page + 1
                    } else {
                        self.starsthipCollectionList?.results.append(contentsOf: starships.results)
                        self.page = self.page + 1
                    }
                    if starships.next != nil {
                        self.getListOfEntities(entity: .starships, page: self.page)
                    }
                }
                if let planets = planets {
                    if self.planetCollectionList?.results == nil {
                        self.planetCollectionList = planets
                        self.page = self.page + 1
                    } else {
                        self.planetCollectionList?.results.append(contentsOf: planets.results)
                        self.page = self.page + 1
                    }
                    if planets.next != nil {
                        self.getListOfEntities(entity: .planets, page: self.page)
                    }
                }
            }
        }
    }
}

