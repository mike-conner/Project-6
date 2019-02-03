//
//  SearchResultsController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    var entity: EntityType?
    var peopleCollectionList: People?
    var vehicleCollectionList: Vehicles?
    var starshipCollectionList: Starships?
    var planetCollectionList: Planets?

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var resultsOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var resultsTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var resultsThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var resultsFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var resultsFive: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))

        if let entity = entity {
            setUpLabelsBasedOnEntity(entity: entity)
            setUpResultsBasedOnEntity(entity: entity)
        }
    }
    
    @objc func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpLabelsBasedOnEntity(entity: EntityType) {
        switch entity {
        case .people:
            labelOne.text = "Born"
            labelTwo.text = "Home"
            labelThree.text = "Height"
            labelFour.text = "Eyes"
            labelFive.text = "Hair"
        case .vehicles, .starships:
            labelOne.text = "Make"
            labelTwo.text = "Cost"
            labelThree.text = "Length"
            labelFour.text = "Class"
            labelFive.text = "Crew"
        default:
            break
        }
    }
    
    func setUpResultsBasedOnEntity(entity: EntityType) {
        switch entity {
        case .people:
            name.text = peopleCollectionList?.results[0].name
            resultsOne.text = peopleCollectionList?.results[0].birthYear
            resultsTwo.text = peopleCollectionList?.results[0].homeworld
            resultsThree.text = peopleCollectionList?.results[0].height
            resultsFour.text = peopleCollectionList?.results[0].eyeColor
            resultsFive.text = peopleCollectionList?.results[0].hairColor
        case .vehicles:
            name.text = vehicleCollectionList?.results[0].name
            resultsOne.text = vehicleCollectionList?.results[0].manufacturer
            resultsTwo.text = vehicleCollectionList?.results[0].costInCredits
            resultsThree.text = vehicleCollectionList?.results[0].length
            resultsFour.text = vehicleCollectionList?.results[0].vehicleClass
            resultsFive.text = vehicleCollectionList?.results[0].crew
        case .starships:
            name.text = starshipCollectionList?.results[0].name
            resultsOne.text = starshipCollectionList?.results[0].manufacturer
            resultsTwo.text = starshipCollectionList?.results[0].costInCredits
            resultsThree.text = starshipCollectionList?.results[0].length
            resultsFour.text = starshipCollectionList?.results[0].starshipClass
            resultsFive.text = starshipCollectionList?.results[0].crew
        default:
            break
        }
    }
}
