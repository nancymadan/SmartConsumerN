//
//  APIHandler.swift
//  swiftTutorail
//
//  Created by Aseem 13 on 09/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON
class APIHandler: NSObject {
    
    func handleUrl(url : String , response  : AnyObject ) -> AnyObject {
        
        switch url {
            
        case "ProductsApi":
            let json =   JSON(response)
            var array = [AnyObject]()
            if json[0].dictionaryValue.count > 0 {
                let modal = BarcodeModal(json: json[0])
                array.append(modal)
            }
           
            return array as AnyObject
            
            
        case "ContactApi":
            let json = JSON(response)
            let modal = ContactModal(json: json)
            return modal
            
        default:
            return "" as AnyObject
        }
        
    }
    
}
