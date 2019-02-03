//
//  SearchResultsController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
        pickerView.delegate = self
        pickerView.dataSource = self

        if let entity = entity {
            setUpLabelsBasedOnEntity(entity: entity)
            setUpResultsBasedOnEntity(entity: entity, index: 0)
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
    
    func setUpResultsBasedOnEntity(entity: EntityType, index: Int) {
        switch entity {
        case .people:
            title = "Characters"
            name.text = peopleCollectionList?.results[index].name
            resultsOne.text = peopleCollectionList?.results[index].birthYear
            resultsTwo.text = peopleCollectionList?.results[index].homeworld
            resultsThree.text = peopleCollectionList?.results[index].height
            resultsFour.text = peopleCollectionList?.results[index].eyeColor
            resultsFive.text = peopleCollectionList?.results[index].hairColor
        case .vehicles:
            title = "Vehicles"
            name.text = vehicleCollectionList?.results[index].name
            resultsOne.text = vehicleCollectionList?.results[index].manufacturer
            resultsTwo.text = vehicleCollectionList?.results[index].costInCredits
            resultsThree.text = vehicleCollectionList?.results[index].length
            resultsFour.text = vehicleCollectionList?.results[index].vehicleClass
            resultsFive.text = vehicleCollectionList?.results[index].crew
        case .starships:
            title = "Starships"
            name.text = starshipCollectionList?.results[index].name
            resultsOne.text = starshipCollectionList?.results[index].manufacturer
            resultsTwo.text = starshipCollectionList?.results[index].costInCredits
            resultsThree.text = starshipCollectionList?.results[index].length
            resultsFour.text = starshipCollectionList?.results[index].starshipClass
            resultsFive.text = starshipCollectionList?.results[index].crew
        default:
            break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if entity?.rawValue == "people" {
            return peopleCollectionList?.results[row].name
        } else if entity?.rawValue == "vehicles" {
            return vehicleCollectionList?.results[row].name
        } else {
            return starshipCollectionList?.results[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if entity?.rawValue == "people" {
            setUpResultsBasedOnEntity(entity: .people, index: row)
        } else if entity?.rawValue == "vehicles" {
            setUpResultsBasedOnEntity(entity: .vehicles, index: row)
        } else {
            setUpResultsBasedOnEntity(entity: .starships, index: row)
        }
    }
}
