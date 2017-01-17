//
//  MainVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    var types: Dictionary<String, Int> = [:]
    var varietals: Dictionary<String, Int> = [:]
    var tastes: Dictionary<String, Int> = [:]
    var regions: Dictionary<String, Int> = [:]
    
    var filterIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // populate regions / types / varietals / tastes
        setup {
            self.updateUI()
        }
    }
    
    @IBAction func filterOneBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: types)
    }
    
    @IBAction func filterTwoBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: varietals)
    }
    
    @IBAction func filterThreeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: tastes)
    }
    
    @IBAction func filterFourBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: regions)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        
        filterIDs = [490, 124, 143]
        performSegue(withIdentifier: "DetailVC", sender: filterIDs)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailVC" {
            if let segueVC = segue.destination as? DetailVC {
                if let filterIDs = sender as? [Int] {
                    segueVC.filters = filterIDs
                }
            }
        }
        else if segue.identifier == "FilterVC" {
            if let segueVC = segue.destination as? FilterVC {
                if let filterOptions = sender as? Dictionary<String, Int> {
                    segueVC.options = filterOptions
                }
            }
        }
    }
    
    //populate wine filters
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
        // reloadData
    }
}


