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
    
    var regions: [WineRegion]!
    var type: Dictionary<String, Int> = [:]
    var varietals: [WineVarietal]!
    var tastes: [WineStyle]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // populate regions / types / varietals / tastes
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup {
            print(self.type)
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
                                                self.type[key] = value
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
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


