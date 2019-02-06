//
//  CustomButton.swift
//  HutchDecor
//
//  Created by Aseem 13 on 15/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadious: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    override func draw(_ rect: CGRect) {
        customInit()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        setNeedsDisplay()
    }
    
    
    func customInit() {
        layer.cornerRadius =  cornerRadious
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        
        if cornerRadious > 0 {
            self.layer.masksToBounds = true;
        }
    }
}
