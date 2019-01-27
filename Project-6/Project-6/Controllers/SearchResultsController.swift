//
//  SearchResultsController.swift
//  Project-6
//
//  Created by Mike Conner on 1/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
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
        
    }
    
    @objc func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
