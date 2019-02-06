//
//  AttributesCollectionCell.swift
//  DataKart
//
//  Created by Aseem 13 on 19/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class AttributesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    func configureCell(str : String) {
        let array = str.components(separatedBy: ",")
        lblTitle.text = array[1]
        lblValue.text = array[0]
    }
}
