//
//  ManufacturerController.swift
//  DataKart
//
//  Created by Aseem 13 on 14/11/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class ManufacturerController: BaseViewController {
    
    
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
 
    
    var modalContact = ContactModal()
    var isPopUpPresent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        // Do any additional setup after loading the view.
    }
    
    func setData() {
        
        if let address : String = modalContact.address , let city : String = modalContact.city , let postalCode : String = modalContact.postalCode {
            var str = "\(address) \(city), \(postalCode)".capitalized
            
            str = str.replacingOccurrences(of: "\n", with: "")
            
            str = str.replacingOccurrences(of: "\r", with: "")
            
            lblAddress?.text = str
            btnPhone.setTitle(modalContact.telephone, for: .normal)
            lblCompanyName?.text = modalContact.name?.capitalized
        }
        
        
        self.showAlert(msg: "Product details and images not provided by manufacturer in DataKart",title: "Sorry")
        
    }
    
    func setDataModal(modal : ContactModal){
        modalContact = modal
        
    }
    @IBAction func btnPhone(_ sender: AnyObject) {
        
        if let array = modalContact.telephone?.components(separatedBy: "/"){
            UIApplication.shared.openURL(NSURL(string: ("tel:\(array[0])"))! as URL)
        }
        
        
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(msg : String,title: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
