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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func starWarsObjectSelection (_ sender: UIButton) {
        switch sender.tag {
        case 0:
            getListOfEntities(entity: .people)
            performSegue(withIdentifier: "starWarSegue", sender: self)
        case 1:
            getListOfEntities(entity: .vehicles)
            performSegue(withIdentifier: "starWarSegue", sender: self)
        case 2:
            getListOfEntities(entity: .starships)
            performSegue(withIdentifier: "starWarSegue", sender: self)
        default:
            break
        }
    }
    
    func getListOfEntities(entity: EntityType) {
        client.getEntityList(entityType: entity) { entity1, entity2, entity3, error in
            if let entity = entity1 {
                print(entity.results.count)
                dump(entity)
            }
            if let entity = entity2 {
                print(entity.results.count)
                dump(entity)
            }
            if let entity = entity3 {
                print(entity.results.count)
                dump(entity)
            }
        }
    }
}

