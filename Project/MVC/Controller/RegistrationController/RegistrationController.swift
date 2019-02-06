//
//  RegistrationController.swift
//  JagrukGrahak
//
//  Created by Aseem 13 on 23/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegistrationController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(RegistrationController.update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
//    func update(){
//        if appDelegate.latitude == nil {
//            SharedClass.shared.getCoordinates()
//        }
//    }
    
    func parametersDict() -> [String : AnyObject] {
        
//        let dict = ["name":txtName.text!, "phone_no" : txtPhone.text!,"email_id":txtEmail.text!, "company":txtCompany.text!,"designation" : txtDesignation.text!, "imei": appDelegate.deviceTokenString ?? "","latitude":String(appDelegate.latitude ?? 0),"longitude": String(appDelegate.longitude ?? 0)]
        
        
        let dict = ["name":txtName.text!, "phone_no" : txtPhone.text!,"email_id":txtEmail.text!, "company":txtCompany.text!,"designation" : txtDesignation.text!, "imei": "","latitude":"","longitude": ""]
        
        return dict as [String : AnyObject]
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == txtPhone){
            
            if(range.length + range.location > textField.text?.count ?? 0){
                return false;
            }
            let newLength = (textField.text?.count)! + string.count - range.length
            return newLength <= 10;
        }
        return true
    }
    
    @IBAction func btnRegister(_ sender: AnyObject) {
        
        let value = ValidationClass().validateRegistration(name: txtName.text!, MobileNo: txtPhone.text!, Email: txtEmail.text!)
        if value == 0 {
            SharedClass.shared.loaderGif()
            
            APIManager().postWebRequest(urlString: "https://gs1datakart.org/api/v5/register?apiId=df4a3e288e73d4e3d6e4a975a0c3212d&apiKey=440f00981a1cc3b1ce6a4c784a4b84ea", Parameters: parametersDict(), successResponse: { (response) in
                
                SharedClass.shared.removeLoader()
                let json =   JSON(response!)
                
                if json["success"][0].dictionaryValue.count > 0 {

                    UserDefaults.standard.set("1", forKey: "Registration")
                    UserDefaults.standard.set(self.txtPhone.text, forKey: "PhoneNumber")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenVC") as? HomeScreenVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                else if json["errors"][0].dictionaryValue.count > 0 {
                    let msg = json["errors"][0]["message"].stringValue
                    self.showAlert(msg: msg)
                }
                
                
                },failureResponse: { (failure) in
                    print(failure)
                    let json =   JSON(failure!)
                     if json["errors"][0].dictionaryValue.count > 0 {
                        let msg = json["errors"][0]["message"].stringValue
                        self.showAlert(msg: msg)
                    }
                    SharedClass.shared.removeLoader()
            })
        }
    }
    
    func showAlert(msg : String)  {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
            
        })
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func btnSkip(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenVC") as? HomeScreenVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}



