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
    
    var options: Dictionary<String, Int>!
    var navTitle: String!
    var selectedIDs: [Int]!
    
    var keys: [String]! // actual ordering of the table
//    var selections: [Bool]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = navTitle.capitalized
        keys = Array(options.keys).sorted()
//        selections = [Bool](repeating: false, count: options.count)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getSelectedIDs() -> [Int] {
//        var ids = [Int]()
//        for (index, selection) in selections.enumerated() {
//            if selection {
//                ids.append(options[keys[index]]!)
//            }
//        }
//        return ids
        return selectedIDs
    }
    
    @IBAction func selectBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
//        for (index, selection) in selections.enumerated() {
//            if selection {
//                selections[index] = false
//            }
//        }
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
//            if selections[indexPath.row] {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selections[indexPath.row] = true
        let id = options[keys[indexPath.row]]!
        if !selectedIDs.contains(id) {
            selectedIDs.append(id)
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        selections[indexPath.row] = false
        let id = options[keys[indexPath.row]]!
        if let index = selectedIDs.index(of: id) {
            selectedIDs.remove(at: index)
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
