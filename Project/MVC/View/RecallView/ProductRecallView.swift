//
//  ProductRecallView.swift
//  JagrukGrahak
//
//  Created by Sierra 4 on 06/09/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductRecallView: UIView {
    
 var recallInfo : [String : JSON]?
    @IBOutlet var lblBatchNumber: UILabel!
    @IBOutlet var lblDesignation: UILabel!
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblContactNum: UILabel!
    
    @IBOutlet var lblEmail: UILabel!
    
    @IBOutlet var recallView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recallView.layoutIfNeeded()
        recallView.layer.cornerRadius = 4.0
       
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func btnRemoveView(_ sender: UIButton) {
       self.removeFromSuperview()
    }
  }
