//
//  AttributesTableCell.swift
//  DataKart
//
//  Created by Aseem 13 on 19/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class AttributesTableCell: UITableViewCell {

    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configureCell(str : String, str2 : String) {
//        let array = str.componentsSeparatedByString(",")
        lblTitle.text = str2
        lblValue.text = str
    }


}
