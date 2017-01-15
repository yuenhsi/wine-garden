//
//  DetailVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import Alamofire

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var filters: [[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // what we need: (490+140+10038)&size=10
        let whatweneed = ""
        let catalogUrl = "\(baseUrl)\(catalogExt)\(whatweneed)&apikey=\(apikey)"
        
        setup {
            self.updateUI()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell") as! WineCell
        return cell
    }
    
    // populate table view with wines
    func setup(completed: @escaping DownloadComplete) {
        
        let filterURL = ""
        Alamofire.request(filterURL).responseJSON { response in
        }
    }
    
    func updateUI() {
        
    }
}
