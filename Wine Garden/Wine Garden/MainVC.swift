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
    var selectedTypeIDs = [Int]()
    var varietals: Dictionary<String, Int> = [:]
    var selectedVarietalIDs = [Int]()
    var tastes: Dictionary<String, Int> = [:]
    var selectedTasteIDs = [Int]()
    var regions: Dictionary<String, Int> = [:]
    var selectedRegionIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // populate regions / types / varietals / tastes
        setup {
            
        }
    }
    
    @IBAction func filterOneBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: (types, "Types", selectedTypeIDs) as FilterVCItems)
    }
    
    @IBAction func filterTwoBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: (varietals, "Varietals", selectedVarietalIDs) as FilterVCItems)
    }
    
    @IBAction func filterThreeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: (tastes, "Tastes", selectedTasteIDs) as FilterVCItems)
    }
    
    @IBAction func filterFourBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: (regions, "Regions", selectedRegionIDs) as FilterVCItems)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        // 490 limits results to wine only
        let filterIDs =  selectedTypeIDs + selectedVarietalIDs + selectedTasteIDs + selectedRegionIDs + [490]
        performSegue(withIdentifier: "DetailVC", sender: filterIDs)
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let segueVC = sender.source as? FilterVC {
            switch segueVC.navTitle {
                case "Types":
                selectedTypeIDs = segueVC.selectedIDs
                case "Varietals":
                selectedVarietalIDs = segueVC.selectedIDs
                case "Tastes":
                    selectedTasteIDs = segueVC.selectedIDs
                case "Regions":
                    selectedRegionIDs = segueVC.selectedIDs
                default:
                    print("Switch case on navTitle defaulted!")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FilterVC" {
            if let segueVC = segue.destination as? FilterVC {
                if let filterItems = sender as? FilterVCItems {
                    segueVC.options = filterItems.options
                    segueVC.navTitle = filterItems.title
                    segueVC.selectedIDs = filterItems.selectedIDs
                }
            }
        } else if segue.identifier == "DetailVC" {
            if let segueVC = segue.destination as? DetailVC {
                if let filterIDs = sender as? [Int] {
                    segueVC.filters = filterIDs
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

}


