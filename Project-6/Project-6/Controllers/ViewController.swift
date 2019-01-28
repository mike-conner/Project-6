//
//  ViewController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterSegue" {
            let characterData = Stub()
            
            guard let navigationController = segue.destination as? UINavigationController, let searchResultsController = navigationController.topViewController as? SearchResultsController else { return }
            
            searchResultsController.stub = characterData
        }
    }
    
    

}

