//
//  FilterVC.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/17/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class FilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    var options: Dictionary<String, Int>!
    var navTitle: String!
    var selectedIDs: [Int]!
    var keys: [String]! // actual ordering of the table


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTitle.title = navTitle.capitalized

        keys = Array(options.keys).sorted()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        selectedIDs.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WineFilterCell") as? WineFilterCell {
            let filterName = keys[indexPath.row]
            cell.textLabel?.text = filterName
            if selectedIDs.contains(options[filterName]!) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = options[keys[indexPath.row]]!
        if !selectedIDs.contains(id) {
            selectedIDs.append(id)
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let id = options[keys[indexPath.row]]!
        if let index = selectedIDs.index(of: id) {
            selectedIDs.remove(at: index)
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
