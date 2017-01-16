//
//  DetailVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import Alamofire

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var filters: [Int]!
    var catalogUrl: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        var categories = ""

        for (index,filter) in filters.enumerated()
        {
            categories += "\(filter)"
            if index != (filters.count - 1)
            {
                categories += "+"
            }
            
        }
        catalogUrl = "\(baseUrl)\(catalogExt)\(categories)&size=10&apikey=\(apikey)"
        setup {
            self.updateUI()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell") as! WineCell
        return cell
    }
    
    // populate table view with wines
    func setup(completed: @escaping DownloadComplete)
    {
        Alamofire.request(catalogUrl).responseJSON { response in
            // Labels-Url
            if let JSON = response.result.value as? Dictionary<String, Any>
            {
                if let products = JSON["Products"] as? Dictionary<String, Any>
                {
                    if let lists = products["List"] as? [Dictionary<String, Any>]
                    {
                        for list in lists
                        {
                            if let id = list["Id"] as? Int 
                            {
                                print("ID is \(id)")
                            }
                            if let name = list["Name"] as? String
                            {
                                print("Name is \(name)")
                            }
                            if let vintage = list["Vintage"] as? String
                            {
                                print("Vintage is \(vintage)")
                            }
                            if let appelation = list["Appellation"] as? Dictionary<String, Any>
                            {
                                if let appelationName = appelation["Name"] as? String
                                {
                                    print("App Name is \(appelationName)")
                                }
                                if let region = appelation["Region"] as? Dictionary<String, Any>
                                {
                                    if let regionName = region["Name"] as? String
                                    {
                                        print("regionName is \(regionName)")
                                    }
                                }
                            }
                            if let varietal = list["Varietal"] as? Dictionary<String, Any>
                            {
                                if let varietalName = varietal["Name"] as? String
                                {
                                    print("varietalName is \(varietalName)")
                                }
                            }
                            if let label = list["Labels"] as? [Dictionary<String, String>], label.count > 0
                            {
                                if let thumbnail = label[0]["Url"]
                                {
                                    print("thumbnail url is \(thumbnail)")
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
    func updateUI()
    {
        
    }
}
