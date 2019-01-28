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

    @IBAction func entitySelection(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            print("characters")
        case 1:
            print("vehicles")
        case 2:
            print("starships")
        default:
            break
        }
        
    }
    
    

}

