//
//  APIManager.swift
//  swiftTutorail
//
//  Created by Aseem 13 on 09/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON
typealias successBlock = (_ success: AnyObject? ) -> ()
typealias failureBlock = (_ failure: NSError? ) -> ()

class APIManager: NSObject {

   static let sharedInstance = APIManager()
    var apiHandler : APIHandler?
    var httpClient : HTTPClient?
    
    func postWebRequest(urlString : String? , Parameters: [String : AnyObject] , successResponse : @escaping successBlock , failureResponse : @escaping failureBlock)  {
        
        HTTPClient().postData(urlStr: urlString ?? "", paramaters: Parameters , success: { (success) in
            
            successResponse(success)
            
            }, failure: { (failure) in
                failureResponse(failure)
        })
    }
    
    
    func getWebRequest(urlString : String? ,key : String , Parameters: [String : AnyObject], successResponse : @escaping successBlock , failureResponse : @escaping failureBlock)  {
        
        HTTPClient().getData(urlStr: urlString ?? "" ,paramaters: Parameters, successB: { (success) in
            
            let modal = APIHandler().handleUrl(url: key, response: success!)
            
            successResponse(modal)
            
                
            }, failure: { (failure) in
                failureResponse(failure)
        })
    }
                                                                                                                                                                             
}
