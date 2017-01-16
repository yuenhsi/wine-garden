//
//  WineCell.swift
//  Wine Garden
//
//  Created by Yuen Hsi Chang on 1/13/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//


import UIKit

class WineCell: UITableViewCell {

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var varietalLbl: UILabel!
    @IBOutlet weak var appelationLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    
    var wine: Wine!
    
    func configureCell() {
        
    }
    
}
