//
//  CircleVIew.swift
//  AshiLLC-Housing
//
//  Created by Pranjal Kukreja on 3/15/17.
//  Copyright © 2017 Pranjal Kukreja. All rights reserved.
//

import UIKit

class CircleVIew: UIImageView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    
    override func layoutSubviews() {
        
       super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        
    }

}
