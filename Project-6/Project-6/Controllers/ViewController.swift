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
    var peoplePageCounter = 1
    var vehiclePageCounter = 1
    var starshipPageCounter = 1
    var planetPageCounter = 1
    
    var peopleCollectionList: People?
    var vehicleCollectionList: Vehicles?
    var starsthipCollectionList: Starships?
    var planetCollectionList: Planets?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfEntities(entity: .people, page: peoplePageCounter)
        getListOfEntities(entity: .vehicles, page: vehiclePageCounter)
        getListOfEntities(entity: .starships, page: starshipPageCounter)
        getListOfEntities(entity: .planets, page: planetPageCounter)
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
        self.client.getEntityList(entityType: entity, page: page) { people, vehicles, starships, planets, error in
            if let people = people {
                if self.peopleCollectionList?.results == nil {
                    self.peopleCollectionList = people
                    self.peoplePageCounter = page + 1
                } else {
                    self.peopleCollectionList?.results.append(contentsOf: people.results)
                    self.peoplePageCounter = page + 1
                }
                if people.next != nil {
                    self.getListOfEntities(entity: .people, page: self.peoplePageCounter)
                }
            }
            if let vehicles = vehicles {
                if self.vehicleCollectionList?.results == nil {
                    self.vehicleCollectionList = vehicles
                    self.vehiclePageCounter = page + 1
                } else {
                    self.vehicleCollectionList?.results.append(contentsOf: vehicles.results)
                    self.vehiclePageCounter = page + 1
                }
                if vehicles.next != nil {
                    self.getListOfEntities(entity: .vehicles, page: self.vehiclePageCounter)
                }
            }
            if let starships = starships {
                if self.starsthipCollectionList?.results == nil {
                    self.starsthipCollectionList = starships
                    self.starshipPageCounter = page + 1
                } else {
                    self.starsthipCollectionList?.results.append(contentsOf: starships.results)
                    self.starshipPageCounter = page + 1
                }
                if starships.next != nil {
                    self.getListOfEntities(entity: .starships, page: self.starshipPageCounter)
                }
            }
            if let planets = planets {
                if self.planetCollectionList?.results == nil {
                    self.planetCollectionList = planets
                    self.planetPageCounter = page + 1
                } else {
                    self.planetCollectionList?.results.append(contentsOf: planets.results)
                    self.planetPageCounter = page + 1
                }
                if planets.next != nil {
                    self.getListOfEntities(entity: .planets, page: self.planetPageCounter)
                }
            }
            if let error = error {
                let errorMessage: String?
                switch error {
                case SWAPIError.requestFailed:
                    errorMessage = "Your request failed!"
                case SWAPIError.responseUnsuccessful:
//                    let statusCode = SWAPIError.responseUnsuccessful.statusCode
                    errorMessage = "No response from server! Status code: )"
                case SWAPIError.invalidData:
                    errorMessage = "The data was invalid!"
                case SWAPIError.jsonParsingFailure:
                    errorMessage = "The JSON could not be Parsed!"
                case SWAPIError.invalidUrl:
                    errorMessage = "The URL was invalid!"
                default:
                    errorMessage = "There was an error!"
                }
                guard let alertMessage = errorMessage else { return }
                let alert = UIAlertController(title: "Error", message: "\(alertMessage)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
        }
    }
}

