//
//  MRPCell.swift
//  DataKart
//
//  Created by Aseem 13 on 12/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class MRPCell: UITableViewCell {

    @IBOutlet weak var lblMrpActivationDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMrp: UILabel!
    @IBOutlet weak var lblMrpTitle: UILabel!
    

    func configureCell(item : AnyObject?, isBEE : Bool, isAgmark : Bool){
        
        if isBEE || isAgmark{
            guard let dict = item as? [String: String] else{return}
            lblMrp?.text = dict.values.first
            lblMrpTitle?.text = dict.keys.first
        }else{
            
            guard let item = item as? BarcodeModal2 else{return}
            lblMrp.text = "₹ \(item.mrp!) per unit"
            lblLocation.text = item.location
            lblMrpActivationDate.text = getFormattedDate(stringDate: item.mrpActivationDate!)
        }
        
        
    }
    
    
    func getFormattedDate(stringDate : String) -> String{
        
        var array : [String] = stringDate.components(separatedBy: "-")
        
        return "\(getMonth(month: array[1])) \(array[2]), \(array[0])"
        
        
    }
    
    func getMonth(month : String) -> String {
        
        var string : String
        switch month {
        case "01":
            string = "January"
        case "02":
            string = "February"
        case "03":
            string = "March"
        case "04":
            string = "April"
        case "05":
            string = "May"
        case "06":
            string = "June"
        case "07":
            string = "July"
        case "08":
            string = "August"
        case "09":
            string = "September"
        case "10":
            string = "October"
        case "11":
            string = "November"
        case "12":
            string = "December"
        default:
            string = ""
        }
        
        return  string
    }
    
}
