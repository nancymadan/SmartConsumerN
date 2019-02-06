//
//  FeedbackView.swift
//  HutchDecor
//
//  Created by Aseem 13 on 12/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class FeedbackView: UIView {

    @IBOutlet weak var txtView: UITextView!
    
    override func awakeFromNib() {
        SharedClass.shared.addCorners(cornerRadius: 3.0, borderWidth: 1.0, borderColor: UIColor.gray, view: txtView)
    }
    
    
    @IBAction func btnSubmit(_ sender: AnyObject) {
    }
    @IBAction func btnCancel(_ sender: AnyObject) {
    }
}
