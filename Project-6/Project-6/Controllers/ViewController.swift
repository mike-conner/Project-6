//
//  ViewController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var entityType: EntityType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func starWarsObjectSelection (_ sender: UIButton) {
        switch sender.tag {
        case 0:
            entityType = EntityType.people
        case 1:
            entityType = EntityType.vehicles
        case 2:
            entityType = EntityType.starships
        default:
            break
        }
        performSegue(withIdentifier: "starWarSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let destVC = nav.topViewController as? SearchResultsController {
            destVC.entityType = entityType
        }
    }
}

