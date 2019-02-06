//
//  RatingView.swift
//  JagrukGrahak
//
//  Created by Sierra 4 on 07/09/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import HCSStarRatingView

class RatingView: UIView {

    @IBOutlet var ratingView: HCSStarRatingView!
    
    @IBOutlet var submitBtn: UIButton!
    
    @IBOutlet var ratingAlert: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingAlert.layoutIfNeeded()
        ratingAlert.layer.cornerRadius = 4.0
    }
    
    
    @IBAction func removeFromSuperView(_ sender: UIButton) {
        self.removeFromSuperview()
    }
}
