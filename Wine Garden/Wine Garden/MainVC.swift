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
    var type: [WineType]!
    var varietals: [WineVarietal]!
    var tastes: [WineStyle]!
    
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
                print(JSON)
            }
        }
    }
    
    func updateUI() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return WineCell()
    }
}

