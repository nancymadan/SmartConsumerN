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

    func postData(urlStr : String , paramaters : [String : AnyObject], jsonBody : Bool, success : @escaping successBlock ,  failure : @escaping failureBlock) {
        
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
        if !jsonBody{
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
            return
        }
        do{
        let jsonData = try JSONSerialization.data(withJSONObject: paramaters, options: [])
//           let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//             let dictFromJSON = decoded as? [String:String]
           // let decoded = String(data: jsonData, encoding: .utf8)

          ///  print(decoded)
            var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethod.post.rawValue
      //  request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody =   jsonData
        Alamofire.request(request).validate().responseJSON { (response) in
            
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
        catch {

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


