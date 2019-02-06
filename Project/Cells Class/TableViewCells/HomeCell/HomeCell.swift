//
//  HomeCell.swift
//  DataKart
//
//  Created by Aseem 13 on 23/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var customView: CustomView!
    
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(dict : [String : String]) {
        
        lblProductName.text = dict["productName"]
        lblCompanyName.text = dict["companyName"]
        imageViewProduct.sd_setImage(with: URL(string: dict["image"]!), placeholderImage: UIImage(named: "splash"))
        self.lblTime.text = ""
        if let addedDate = dict["savedTime"]{
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            df.locale = .current
            df.timeZone = .current
            let date = df.date(from: addedDate)
            let time = date?.toStringWithRelativeTime()
            self.lblTime.text = time ?? ""
        }
       
        
    }
}
