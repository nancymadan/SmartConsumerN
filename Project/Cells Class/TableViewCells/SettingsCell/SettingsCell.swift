//
//  SettingsCell.swift
//  DataKart
//
//  Created by Aseem 13 on 20/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title : String?) {
        lblTitle.text = title
    }
}
