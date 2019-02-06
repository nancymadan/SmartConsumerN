//
//  ValidationClass.swift
//  DataKart
//
//  Created by Aseem 13 on 14/12/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class ValidationClass: NSObject {
    
    static let sharedInstance = ValidationClass()
    var appDelegate = AppDelegate()
    var valueVailidation  = 0
    
    
    override init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    func validateFeedback(batchNo : String , Comments : String, MobileNo : String, Email : String,name :String, state : String,pincode :String) -> Int {
        var valueVailidation  = 0
        if valueVailidation == 0 {
            if name.isBlank {
                showAlert(title: "Error !!", msg: "Please enter your Name")
                valueVailidation = 1
            }
            else if batchNo.isBlank {
                showAlert(title: "Error !!", msg: "Please enter the Batch Number")
                valueVailidation = 1
            }
           
            else if Comments.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Comments")
                valueVailidation = 1
            }
            else if MobileNo.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Mobile Number")
                valueVailidation = 1
            }
            else if Email.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Email")
                valueVailidation = 1
            }
            else if !Email.isEmail{
                showAlert(title: "Error !!", msg: "Email format is not correct")
                valueVailidation = 1
            }
            else if !MobileNo.isPhoneNumber{
                showAlert(title: "Error !!", msg: "Phone Number is not valid")
                valueVailidation = 1
            }
            else if pincode.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Pin code")
                valueVailidation = 1
            }
            else if state.isBlank{
                showAlert(title: "Error !!", msg: "Please select a state")
                valueVailidation = 1
            }
          
            
        }
        return valueVailidation
    }
    
    func validateRegistration(name : String , MobileNo : String, Email : String) -> Int {
        var valueVailidation  = 0
        if valueVailidation == 0 {
            if name.isBlank {
                showAlert(title: "Error !!", msg: "Please enter the Batch Number")
                valueVailidation = 1
            }
            else if MobileNo.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Mobile Number")
                valueVailidation = 1
            }
            else if !MobileNo.isPhoneNumber{
                showAlert(title: "Error !!", msg: "Phone Number is not valid")
                valueVailidation = 1
            }
            else if Email.isBlank{
                showAlert(title: "Error !!", msg: "Please enter your Email")
                valueVailidation = 1
            }
            else if !Email.isEmail{
                showAlert(title: "Error !!", msg: "Email format is not correct")
                valueVailidation = 1
            }
            
            
        }
        return valueVailidation
    }

    
    func showAlert(title : String, msg : String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let Cancel = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction!) -> Void in
            alert.dismiss(animated: true, completion: nil)
            
        })
        
        alert.addAction(Cancel)
        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

    
    extension String {
        
        var isBlank: Bool {
            get {
                
                let trimmed = self.trimmingCharacters(in: CharacterSet.whitespaces)
                return trimmed.isEmpty
            }
        }
        //Validate Email
        var isEmail: Bool {
            do {
                let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
                return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
            } catch {
                return false
            }
        }
        
        var isPhoneNumber: Bool {
            
            do {
                let regex = try NSRegularExpression(pattern: "^[0-9]{10}$", options: .caseInsensitive)
                return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
            } catch {
                return false
            }
            
        }
    }

