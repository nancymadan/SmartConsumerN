//
//  HTTPClient.swift
//  swiftTutorail
//
//  Created by Aseem 13 on 09/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HTTPClient: NSObject {

    func postData(urlStr : String , paramaters : [String : AnyObject] , success : @escaping successBlock ,  failure : @escaping failureBlock) {
        
        let webview = UIWebView(frame: CGRect.zero)
        let secretAgent = webview.stringByEvaluatingJavaScript(from: "navigator.userAgent")
        
        let headers = [
            "User-Agent": secretAgent ?? ""
        ]
        print("Method Post")
        print(urlStr)
        print(paramaters)

//        Alamofire.request(urlStr, parameters: paramaters, encoding: .JSON, headers: headers).validate() .responseJSON { response in // 1
//            switch response.result {
//                
//            case .Success:
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    success (success: JSON)
//                }
//            case .Failure(let error):
//                print(error)
//                failure (failure: error)
//            }
//        }
        
        Alamofire.request(urlStr, method: .post, parameters: paramaters, headers: headers).validate().responseJSON { (response) in
            
            response.result.ifSuccess({
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    success (JSON as AnyObject)
                }
            })
            if response.result.isFailure == true {
                if let error = response.result.error{
                    failure (error as NSError)
                }
            }
        }
        
    }
    
    func getData(urlStr : String  , paramaters : [String : AnyObject],  successB : @escaping successBlock ,  failure : @escaping failureBlock) {
       
        let webview = UIWebView(frame: CGRect.zero)
        let secretAgent = webview.stringByEvaluatingJavaScript(from: "navigator.userAgent")
        
        let headers = [
            "User-Agent": secretAgent ?? ""
        ]
        
        print("Method get")
        print(urlStr)
        print(paramaters)
        
        Alamofire.request(urlStr, method: .get, parameters: paramaters, headers: headers).validate().responseJSON { (response) in

            response.result.ifSuccess({
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    successB (JSON as AnyObject)
                }
            })
            if response.result.isFailure == true {
                if let error = response.result.error{
                    failure (error as NSError)
                }
            }
        }
        
        
        
    }
    
    
}


