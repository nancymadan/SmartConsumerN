//
//  SubmitRating.swift
//  JagrukGrahak
//
//  Created by Sierra 4 on 08/09/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SubmitRating {
    
 func submitRating(rating : CGFloat) {
    
    guard let dictInfo = UserDefaults.standard.object(forKey: "ProductInfo") as? NSDictionary else {return}
    guard let productDesc = dictInfo["desc"] else {return}
    guard let gtin = dictInfo["gtinNumber"] else {return}
    guard let productName = dictInfo["productName"] else {return}
    
    let dict : [String : AnyObject] = ["complaint_id": "0" as AnyObject,"gtin":gtin as AnyObject,"product_desc": productDesc as AnyObject ,"product_name" : productName as AnyObject,"rating" :rating as AnyObject]
    
    APIManager().postWebRequest(urlString: "https://gs1datakart.org/api/v5/feedback?apiId=df4a3e288e73d4e3d6e4a975a0c3212d&apiKey=440f00981a1cc3b1ce6a4c784a4b84ea", Parameters: dict, successResponse: { (response) in
        
        SharedClass.shared.removeLoader()
        guard let response = response else {return}
        let json =   JSON(response)
        var msg = String()
        if json["success"][0].dictionaryValue.count > 0 {
            
            msg = json["success"][0]["complaint_id"].stringValue
        }
        
        self.showAlert(msg: "Your complaint reference number is \(msg)")
        
        },failureResponse: { (failure) in
            print(failure)
            SharedClass.shared.removeLoader()
    })
    }
    
    
    func showAlert(msg : String)  {
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
            
        })
        alert.addAction(defaultAction)
        
//        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

}


