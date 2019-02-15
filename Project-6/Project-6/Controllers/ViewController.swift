//
//  ViewController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var entity: EntityType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
}

