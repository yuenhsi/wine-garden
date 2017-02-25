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
    var wines = [Wine]()
    var filters: [Int]!
    var catalogUrl: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.tintColor = UIColor(red:0.27, green:0.05, blue:0.05, alpha: 1.0)
        
        var categories = ""

        for (index,filter) in filters.enumerated()
        {
            categories += "\(filter)"
            if index != (filters.count - 1)
            {
                categories += "+"
            }
            
        }
        catalogUrl = "\(baseUrl)\(catalogExt)(\(categories))&size=50&apikey=\(apikey)"
        print(catalogUrl)
        setup {
            self.updateUI()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return wines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell") as? WineCell {
            cell.configureCell(wine: wines[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
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
                            let newWine = Wine()
                            
                            if let id = list["Id"] as? Int 
                            {
                                newWine.id = id
                            }
                            if let name = list["Name"] as? String
                            {
                                newWine.name = name
                            }
                            if let vintage = list["Vintage"] as? String
                            {
                                newWine.vintage = vintage
                            }
                            if let appelation = list["Appellation"] as? Dictionary<String, Any>
                            {
                                if let appelationName = appelation["Name"] as? String
                                {
                                    newWine.appellation = appelationName
                                }
                                if let region = appelation["Region"] as? Dictionary<String, Any>
                                {
                                    if let regionName = region["Name"] as? String
                                    {
                                        newWine.region = regionName
                                    }
                                }
                            }
                            if let varietal = list["Varietal"] as? Dictionary<String, Any>
                            {
                                if let varietalName = varietal["Name"] as? String
                                {
                                    newWine.varietal = varietalName
                                }
                            }
                            if let label = list["Labels"] as? [Dictionary<String, String>], label.count > 0
                            {
                                if let thumbnail = label[0]["Url"]
                                {
                                    newWine.labelImageUrl = thumbnail
                                }
                            }
                            self.wines.append(newWine)
                            
                        }
                    }
                }
            }
            completed()
        }
    }
    
    func updateUI()
    {
        tableView.reloadData()
    }
}
