//
//  ManufacturerVC.swift
//  DataKart
//
//  Created by Aseem 13 on 21/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class ManufacturerVC: BaseViewController {

    @IBOutlet weak var viewBatchNo: UIView!
    @IBOutlet weak var viewExpiryDate: UIView!
    @IBOutlet weak var viewSerailNumer: UIView!
    @IBOutlet weak var viewSgtin: UIView!
    
    @IBOutlet weak var lblGtin: UILabel!
    
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblBatchNo: UILabel!
    @IBOutlet var lblProductOnRecall: UILabel!
    var isPopUpShown = false
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet var lblBatchNum: UILabel!
    var modalContact = ContactModal()
    var modalBar = BarcodeModal()
    var productRecallView : ProductRecallView?
    var modalPresent = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if modalPresent == 1 || modalPresent == 2{
            setData()
        }
        recallPopUp()
       
    }
    
       func recallPopUp(){
        if let recallInfo = modalBar.recall_info{
            
            if let isRecallInfoEmpty = modalBar.recall_info?.isEmpty{
                print(isRecallInfoEmpty)
                if !(isRecallInfoEmpty){
                    let nib = UINib(nibName: "RecallView", bundle: nil)
                    productRecallView = nib.instantiate(withOwner: nil, options: nil) [0] as? ProductRecallView
                    productRecallView?.alpha = 0
                    productRecallView?.frame = (appDelegate.window?.frame)!
                    productRecallView?.recallInfo = recallInfo
                    appDelegate.window?.addSubview(productRecallView ?? UIView())

                    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {() -> Void in

                        self.productRecallView?.alpha = 1
                        }, completion: {(finished: Bool) -> Void in
                            
                    })
                    

                    isPopUpShown = true
                    setProductRecallView()
                    }
            
        }
        // Do any additional setup after loading the view.
    }
    }
    
    
    
    func setProductRecallView()
    {
        if let recallInfo = modalBar.recall_info{
            if let batchNumber = recallInfo["batch_no"]?.stringValue{
                if let contactDetailsObject=recallInfo["contact_info"]{
                    if (contactDetailsObject.isEmpty)
                    {
                        productRecallView?.lblName.isHidden = true
                        productRecallView?.lblContactNum.isHidden = true
                        productRecallView?.lblEmail.isHidden = true
                        productRecallView?.lblDesignation.isHidden = true
                    }
                    else{
                        let contactPerson=contactDetailsObject["contact_person"].stringValue
                        let designation=contactDetailsObject["designation"].stringValue
                        let telephone=contactDetailsObject["telephone"].stringValue
                        let email=contactDetailsObject["email"].stringValue
                        
                        productRecallView!.lblName.text = "Contact Person :   \(contactPerson)"
                        productRecallView?.lblBatchNumber.text = "\(batchNumber)"
                        productRecallView?.layer.cornerRadius = 20.0
                        productRecallView?.lblDesignation.text = "Designation :   \(designation)"
                        productRecallView?.lblEmail.text = "Email :   \(email)"
                        productRecallView?.lblContactNum.text = "Contact Number :   \(telephone)"
                    }
                    if(isPopUpShown){
                        lblBatchNum.text = "Following batch or batches of this Product is Under Recall,Please Check The Product Label before Use \(batchNumber)"
                        
                        lblProductOnRecall.isHidden = false
                    }
                    
                    
                }
            }
        }
        
    }
    
    func getDataFromModal(modal : ContactModal) {
        
        modalContact = modal
        modalPresent = 1
        setData()
     }
    
    func getDetailsFromBarcode(modal : BarcodeModal){
        
         modalBar = modal
         modalPresent = 2
       
    }
    
    
    func setData() {
        
        if modalPresent == 1 {
            if let address : String = modalContact.address , let city : String = modalContact.city , let postalCode : String = modalContact.postalCode {
                var str = "\(address) \(city), \(postalCode)".capitalized
                str = str.replacingOccurrences(of: "\n", with: "")
                str = str.replacingOccurrences(of: "\r", with: "")
                
                lblAddress?.text = str
                lblCompanyName?.text = modalContact.name?.capitalized
            }
            
        }else  if modalPresent == 2{
            
            lblCompanyName?.text = modalBar.manufacturerName?.capitalized
            
            if let address : String = modalBar.manufacturerAddress , let city : String = modalBar.manufacturerCity , let postalCode : String = modalBar.manufacturerPostalCode {
                var str = "\(address) \(city), \(postalCode)".capitalized
                str = str.replacingOccurrences(of: "\n", with: "")
                str = str.replacingOccurrences(of: "\r", with: "")
                lblAddress?.text = str
                
            }
            self.viewSgtin.isHidden  = true;
            self.viewBatchNo.isHidden  = true;
            self.viewSerailNumer.isHidden  = true;
            self.viewExpiryDate.isHidden = true
            if modalBar.batchNo != nil && modalBar.batchNo != ""{
                self.lblBatchNo.text = modalBar.batchNo
                self.viewBatchNo.isHidden = false
            }
            if modalBar.serialNumber != nil && modalBar.serialNumber != ""{
                self.lblSerialNo.text = modalBar.serialNumber
                self.viewSerailNumer.isHidden = false

            }
            if modalBar.expiryDate != nil && modalBar.expiryDate != ""{
                self.lblExpiryDate.text = modalBar.expiryDate
                self.viewExpiryDate.isHidden = false

            }
            if modalBar.SGtin != nil && modalBar.SGtin != ""{
                self.lblGtin.text = modalBar.SGtin
                self.viewSgtin.isHidden = false

            }
            
        }
        
    }
    
    
    func setDataModal(modal : ContactModal){
        modalContact = modal
        modalPresent = 1
    }
    
    @IBAction func btnPhone(_ sender: AnyObject) {
        
        if let array = modalContact.telephone?.components(separatedBy: "/"){
            UIApplication.shared.openURL(NSURL(string: ("tel:\(array[0])"))! as URL)
        }
        
        
    }
    
    

}
