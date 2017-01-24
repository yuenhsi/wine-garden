//
//  CustomButton.swift
//  Wine Garden
//
//  Created by Jennie on 1/22/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        updateLayerProperties()
    }
    
    func updateLayerProperties()
    {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha:1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }

}
