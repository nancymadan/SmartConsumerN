//
//  LayerCategory.swift
//  HutchDecor
//
//  Created by Aseem 13 on 12/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

var borderUIColor : UIColor?

extension CALayer {
     func setBorderUIColor(color: UIColor?) {
        self.borderColor = color?.cgColor
    }
     func borderUIColor() -> UIColor {
        return UIColor(cgColor:borderColor!)
    }
}
