//
//  BarcodeModal.swift
//  DataKart
//
//  Created by Aseem 13 on 22/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON

class BarcodeModal: NSObject {

    
    var desct : String?
    var category : String?
    var measurementUnit : String?
    var subCategory : String?
    var gtinNo : String?
    var url : String?
    var brand  : String?
    var mrpInfo : [BarcodeModal2]? = []
    var ImageFront : String?
    var ImageBack : String?
    var Imagebottom : String?
    var Imageleft : String?
    var Imageright : String?
    var Imagetop : String?
    var Imagetop_left : String?
    var Imagetop_right : String?
    
    var video_url : String?
    
    var ImagesArray : [String]? = []
    var grossWeight : String?
    var name : String?
    var netWeight : String?
    var netContent : String?
    var website : String?
    
    var licNo : String?
    var isiNo : String?
    var foodType : String?
    var selfLyf : String?
    
    var consumerName : String?
    var consumerNumber : String?
    var consumerEmail : String?
    var consumerAddress : String?
    
    var manufacturerName : String?
    var manufacturerAddress : String?
    var manufacturerCity : String?
    var manufacturerPostalCode : String?
    var storageCondition : String?

    var recall_info : [String : JSON]?
    
    var beeArray : [[String : String]]? = []
    var agmarkArray : [[String : String]]? = []
    var fssai_url : String?
    
    var batchNo : String?
    var expiryDate : String?
    var SGtin : String?
    var serialNumber : String?
   
    var hsCode : String?
    var cgst : String?
    var sgst : String?
    var igst : String?
    init(json:JSON) {
        super.init()
        desct = json["description"].stringValue
        category = json["category"].stringValue
        fssai_url = json["fssai_url"].stringValue
        measurementUnit = json["weights_and_measures"]["measurement_unit"].stringValue

        subCategory = json["sub_category"].stringValue
        gtinNo = json["gtin"].stringValue
        url = json["url"].stringValue
        brand = json["brand"].stringValue
        recall_info = json["recall_info"].dictionaryValue
        for dict in json["mrp"] {
            mrpInfo?.append(BarcodeModal2(json: dict.1))
        }
        
        ImageFront = json["images"]["front"]["large"].stringValue
        ImageBack = json["images"]["back"]["large"].stringValue
        Imagebottom = json["images"]["bottom"]["large"].stringValue
        Imageleft = json["images"]["left"]["large"].stringValue
        Imageright = json["images"]["right"]["large"].stringValue
        Imagetop = json["images"]["top"]["large"].stringValue
        Imagetop_left = json["images"]["top_left"]["large"].stringValue
        Imagetop_right = json["images"]["top_right"]["large"].stringValue
        
        video_url = json["video_url"].stringValue
        
        let array = [ImageFront,ImageBack ?? "", Imagebottom ?? "", Imageleft ?? "", Imageright ?? "", Imagetop ?? "", Imagetop_left ?? "", Imagetop_right ?? "", video_url ?? ""]
        
        updateArray(array: array as! [String])
        
        consumerName = json["consumer_care"]["contact_person"].stringValue
        consumerNumber = json["consumer_care"]["contact_no"].stringValue
        consumerEmail = json["consumer_care"]["email"].stringValue
        consumerAddress = json["consumer_care"]["address"].stringValue
        
        website = json["company_detail"]["contact_info"]["website"].stringValue
        
        grossWeight = json["weights_and_measures"]["gross_weight"].stringValue
        name = json["name"].stringValue
        netWeight = json["weights_and_measures"]["net_weight"].stringValue
        netContent = json["weights_and_measures"]["net_content"].stringValue
        
        manufacturerName = json["company_detail"]["name"].stringValue
        manufacturerAddress = json["company_detail"]["address"]["address1"].stringValue
        manufacturerCity = json["company_detail"]["address"]["city"].stringValue
        manufacturerPostalCode = json["company_detail"]["address"]["pincode"].stringValue
        
        licNo = json["attributes"]["regulatory_data"]["child"]["fssai_lic._no."].stringValue
        isiNo = json["attributes"]["regulatory_data"]["child"]["isi_no."].stringValue
        foodType = json["attributes"]["regulatory_data"]["child"]["food_type"].stringValue
        storageCondition = json["attributes"]["storage_condition"].stringValue

        batchNo = json["qrdata"]["Batch No."].stringValue
        expiryDate = json["qrdata"]["Expiry Date"].stringValue
        serialNumber = json["qrdata"]["Serial Number"].stringValue
        SGtin = json["qrdata"]["SGTIN"].stringValue

           hsCode = json["hs_code"].stringValue
           cgst = json["cgst"].stringValue
           sgst = json["sgst"].stringValue
           igst = json["igst"].stringValue
        
        let value = json["attributes"]["shelf_life"]["child"]["value"].stringValue
        let unit = json["attributes"]["shelf_life"]["child"]["unit"].stringValue
        let basedOn = json["attributes"]["shelf_life"]["child"]["based_on"].stringValue
        
        if !value.isBlank{
            selfLyf = "\(value) \(unit) based on \(basedOn)"
        }
        
        for dict in json["bee"] {
            beeArray?.append([dict.0 : dict.1.stringValue])
        }
        
        for dict in json["attributes"]["agmark"]["child"] {
            agmarkArray?.append([dict.0 : dict.1.stringValue])
        }
        
    }
    
    func updateArray(array : [String]){
        
        for item in array {
            if item != "" {
                ImagesArray?.append(item)
            }
        }
    }
    override init() {
        super.init()
    }
}

class BarcodeModal2: NSObject {
    
    var mrp : String?
    var location : String?
    var mrpActivationDate :  String?
    
    init(json : JSON) {
        mrp = json["mrp"].stringValue
        location = json["location"].stringValue
        mrpActivationDate = json["activation_date"].stringValue
    }
    
    override init() {
        super.init()
    }
}


