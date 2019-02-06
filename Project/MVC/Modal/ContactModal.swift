//
//  ContactModal.swift
//  DataKart
//
//  Created by Aseem 13 on 23/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactModal: NSObject {

    
    var name : String?
    var gcp : String?
    var address : String?
    var city : String?
    var postalCode : String?
    var contactPerson : String?
    var telephone  : String?
    var message : String?
    var code : String?
    
    init(json:JSON) {
        
        super.init()
        name = json["name"].stringValue
        gcp = json["category"].stringValue
        address = json["address"].stringValue
        city = json["city"].stringValue
        postalCode = json["postalCode"].stringValue
        contactPerson = json["contactPerson"].stringValue
        telephone = json["telephone"].stringValue
        message = json["error"]["message"].stringValue
        code = json["error"]["code"].stringValue
        
    }
    
    override init() {
        super.init()
    }

}
