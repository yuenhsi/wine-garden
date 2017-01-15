//
//  DetailVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var filters: [[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell") as! WineCell
        return cell
    }
    
    func setup() {
        Alamofire.request(categoryUrl).responseJSON { response in
        }
    }
}
