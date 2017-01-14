//
//  MainVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var types: Dictionary<String, Int> = [:]
    var varietals: Dictionary<String, Int> = [:]
    var tastes: Dictionary<String, Int> = [:]
    var regions: Dictionary<String, Int> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // populate regions / types / varietals / tastes
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup {
            self.updateUI()
        }
    }

    //populate wine lists
    func setup(completed: @escaping DownloadComplete) {
        Alamofire.request(categoryUrl).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String, Any> {
                if let categories = JSON["Categories"] as? [Dictionary<String, Any>] {
                    for category in categories {
                        if let name = category["Name"] as? String {
                            switch name {
                            case "Wine Type":
                                if let refinements = category["Refinements"] as? [Dictionary<String, Any>] {
                                    for refinement in refinements {
                                        if let key = refinement["Name"] as? String {
                                            if let value = refinement["Id"] as? Int {
                                                self.types[key] = value
                                            }
                                        }
                                    }
                                }
                            case "Varietal":
                                if let refinements = category["Refinements"] as? [Dictionary<String, Any>] {
                                    for refinement in refinements {
                                        if let key = refinement["Name"] as? String {
                                            if let value = refinement["Id"] as? Int {
                                                self.varietals[key] = value
                                            }
                                        }
                                    }
                                }
                            case "Wine Style":
                                if let refinements = category["Refinements"] as? [Dictionary<String, Any>] {
                                    for refinement in refinements {
                                        if let key = refinement["Name"] as? String {
                                            if let value = refinement["Id"] as? Int {
                                                self.tastes[key] = value
                                            }
                                        }
                                    }
                                }
                            case "Region":
                                if let refinements = category["Refinements"] as? [Dictionary<String, Any>] {
                                    for refinement in refinements {
                                        if let key = refinement["Name"] as? String {
                                            if let value = refinement["Id"] as? Int {
                                                self.regions[key] = value
                                            }
                                        }
                                    }
                                }
                            default:
                                break
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
    func updateUI() {
        print(self.types)
        print(self.varietals)
        print(self.tastes)
        print(self.regions)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


