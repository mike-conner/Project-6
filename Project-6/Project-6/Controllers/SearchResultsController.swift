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
    
    var selectedIndexOfCollectionLists: Int = 0
    
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
    @IBOutlet weak var costConverterSwitch: UISegmentedControl!
    @IBOutlet weak var sizeConverterSwitch: UISegmentedControl!
    
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
    
    @IBAction func changeMonetaryType(_ sender: Any) {
        if costConverterSwitch.selectedSegmentIndex == 1 {
            showInputDialog(title: "Exchange rate",
                            subtitle: "Please enter an exchange rate (positive numbers only).",
                            actionTitle: "Submit",
                            cancelTitle: "Cancel",
                            inputPlaceholder: "Ex: \"1.5\"",
                            inputKeyboardType: .numberPad)
            { (input:String?) in
                if input == "" {
                    self.costConverterSwitch.selectedSegmentIndex = 0
                } else {
                    guard let conversionRate = input?.toDouble() else { return }
                    guard let costInCredits = self.resultsTwo.text?.toDouble() else { return }
                    let costInDollars = String(costInCredits * conversionRate)
                    self.resultsTwo.text = costInDollars.toCurrencyFormat()
                }
            }
        } else {
            if entity == .vehicles {
                guard let costInCredits = vehicleCollectionList?.results[selectedIndexOfCollectionLists].costInCredits else { return }
                resultsTwo.text = costInCredits
            } else {
                guard let costInCredits = starshipCollectionList?.results[selectedIndexOfCollectionLists].costInCredits else { return }
                resultsTwo.text = costInCredits
            }
        }
    }
    
    @IBAction func changeLengthType(_ sender: Any) {
        if sizeConverterSwitch.selectedSegmentIndex == 1 {
            if let currentHeight = resultsThree.text {
                let decimals = Set("0123456789.")
                guard var newHeight = String(currentHeight.filter{decimals.contains($0)}).toDouble() else { return }
                newHeight = newHeight*3.2808
                newHeight = Double(String(format: "%.2f", newHeight)) ?? 0
                resultsThree.text = "\(newHeight)ft"
            }
        } else {
            if let currentHeight = resultsThree.text {
                let decimals = Set("0123456789.")
                guard var newHeight = String(currentHeight.filter{decimals.contains($0)}).toDouble() else { return }
                newHeight = newHeight/3.2808
                newHeight = Double(String(format: "%.2f", newHeight)) ?? 0
                resultsThree.text = "\(newHeight)m"
            }
        }
    }
    
    func setUpLabelsBasedOnEntity(entity: EntityType) {
        switch entity {
        case .people:
            labelOne.text = "Born"
            labelTwo.text = "Home"
            labelThree.text = "Height"
            labelFour.text = "Eyes"
            labelFive.text = "Hair"
            costConverterSwitch.isHidden = true
            
        case .vehicles, .starships:
            labelOne.text = "Make"
            labelTwo.text = "Cost"
            labelThree.text = "Length"
            labelFour.text = "Class"
            labelFive.text = "Crew"
            costConverterSwitch.isHidden = false
            
        default:
            break
        }
    }
    
    func setUpResultsBasedOnEntity(entity: EntityType, index: Int) {
        selectedIndexOfCollectionLists = index
        switch entity {
        case .people:
            
            title = "Characters"
            name.text = peopleCollectionList?.results[index].name
            if peopleCollectionList?.results[index].birthYear == "unknown" {
                resultsOne.text = "Birth year unknown"
            } else {
                resultsOne.text = peopleCollectionList?.results[index].birthYear
            }
            if let homeworldName = peopleCollectionList?.results[index].getPlanetName(personUrl: peopleCollectionList?.results[index].homeworld ?? "", planets: planetCollectionList) {
                if homeworldName == "unknown" {
                    resultsTwo.text = "Homeworld unknown"
                } else {
                    resultsTwo.text = homeworldName
                }
            }
            if let height = peopleCollectionList?.results[index].height.toDouble() {
                switch sizeConverterSwitch.selectedSegmentIndex {
                case 0:
                    let displayedHeight = height/100
                    resultsThree.text = "\(displayedHeight)m"
                case 1:
                    let displayHeight = height*3.2808
                    resultsThree.text = "\(displayHeight)ft"
                default:
                    break
                }
                var displayedHeight = height
                displayedHeight = height/100
                resultsThree.text = "\(displayedHeight)m"
            }
            if peopleCollectionList?.results[index].eyeColor == "unknown" {
                resultsFour.text = "Eye color unknown"
            } else {
                resultsFour.text = peopleCollectionList?.results[index].eyeColor.capitalized
            }
            if peopleCollectionList?.results[index].hairColor == "n/a" || peopleCollectionList?.results[index].hairColor == "none" {
                resultsFive.text = "Character has no hair"
            } else if peopleCollectionList?.results[index].hairColor == "unknown" {
                resultsFive.text = "Hair color unknown"
            } else {
                resultsFive.text = peopleCollectionList?.results[index].hairColor.capitalized
            }
        case .vehicles:
            title = "Vehicles"
            name.text = vehicleCollectionList?.results[index].name
            if vehicleCollectionList?.results[index].manufacturer == "unknown" {
                resultsOne.text = "Manufacturer unknown"
            } else {
                resultsOne.text = vehicleCollectionList?.results[index].manufacturer
            }
            if vehicleCollectionList?.results[index].costInCredits == "unknown" {
                resultsTwo.text = "Cost unknown"
            } else {
                resultsTwo.text = vehicleCollectionList?.results[index].costInCredits
            }
            if let length = vehicleCollectionList?.results[index].length.toDouble() {
                resultsThree.text = "\(length)m"
            }
            resultsFour.text = vehicleCollectionList?.results[index].vehicleClass.capitalized
            resultsFive.text = vehicleCollectionList?.results[index].crew
        case .starships:
            title = "Starships"
            name.text = starshipCollectionList?.results[index].name
            if starshipCollectionList?.results[index].manufacturer == "unknown" {
                resultsOne.text = "Manufacturer unknown"
            } else {
                resultsOne.text = starshipCollectionList?.results[index].manufacturer
            }
            if starshipCollectionList?.results[index].costInCredits == "unknown" {
                resultsTwo.text = "Cost unknown"
            } else {
                resultsTwo.text = starshipCollectionList?.results[index].costInCredits
            }
            if let length = starshipCollectionList?.results[index].length.toDouble() {
                resultsThree.text = "\(length)m"
            }
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
        switch self.entity?.rawValue {
        case "people":
            guard let numberOfRows = peopleCollectionList?.results.count else { return 0 }
            return numberOfRows
        case "vehicles":
            guard let numberOfRows = vehicleCollectionList?.results.count else { return 0 }
            return numberOfRows
        case "starships":
            guard let numberOfRows = starshipCollectionList?.results.count else { return 0 }
            return numberOfRows
        default:
        return 0
        }
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
        costConverterSwitch.selectedSegmentIndex = 0
        sizeConverterSwitch.selectedSegmentIndex = 0
        if entity?.rawValue == "people" {
            setUpResultsBasedOnEntity(entity: .people, index: row)
        } else if entity?.rawValue == "vehicles" {
            setUpResultsBasedOnEntity(entity: .vehicles, index: row)
        } else {
            setUpResultsBasedOnEntity(entity: .starships, index: row)
        }
    }
    
    
}

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
