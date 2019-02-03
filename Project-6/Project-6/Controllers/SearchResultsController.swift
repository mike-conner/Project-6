//
//  SearchResultsController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    var entityType: EntityType?
    let client = SWAPIClient(configuration: .default)
    var peopleCollection: People?
    var vehicleCollection: Vehicles?
    var starshipCollecion: Starships?

    
    @IBOutlet weak var resultsName: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var makeResultLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costResultLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var lengthResultLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classResultLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var crewResultsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
    
        if let type = entityType {
            getListOfEntities(entity: type)
        }
        configureView()
    }
    
    @objc func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        if peopleCollection?.results.count ?? 0 > 0 {
            resultsName.text = peopleCollection?.results[0].name
            makeResultLabel.text = peopleCollection?.results[0].birthYear
            costResultLabel.text = peopleCollection?.results[0].homeworld
            lengthResultLabel.text = peopleCollection?.results[0].height
            classResultLabel.text = peopleCollection?.results[0].eyeColor
            crewResultsLabel.text = peopleCollection?.results[0].hairColor
        }
    }
    
    func getListOfEntities(entity: EntityType) {
        DispatchQueue.main.async {
            self.client.getEntityList(entityType: entity) { people, vehicles, starships, error in
                if let people = people {
                    self.peopleCollection = people
                    self.configureView()
                }
                if let vehicles = vehicles {
                    self.vehicleCollection = vehicles
                    self.configureView()
                }
                if let starships = starships {
                    self.starshipCollecion = starships
                    self.configureView()
                }
            }
        }
    }

}
