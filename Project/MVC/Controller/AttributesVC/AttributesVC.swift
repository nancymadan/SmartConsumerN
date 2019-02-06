//
//  AttributesVC.swift
//  DataKart
//
//  Created by Aseem 13 on 21/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit


class AttributesVC: BaseViewController{
    
   private var modalBar : BarcodeModal?
    
    @IBOutlet weak var lblNetContent: UILabel!
    @IBOutlet weak var btnWebsite: UIButton!
    @IBOutlet weak var lblGrossWt: UILabel!
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblGTINNo: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblNetWeight: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    func setupUI(){
        
        lblProductName.text = modalBar?.name
        lblBrandName.text = modalBar?.brand
        lblGTINNo.text = modalBar?.gtinNo
        lblDescription.text = modalBar?.desct
        lblCategory.text = "\(modalBar?.category ?? "")/" + (modalBar?.subCategory ?? "")
          lblNetContent.text = modalBar?.netContent
        let unit = modalBar?.measurementUnit
        if unit == "Other" {
            lblNetWeight.text = modalBar?.netWeight
          

            lblGrossWt.text = modalBar?.grossWeight
        }else{
            lblNetWeight.text = "\(modalBar?.netWeight ?? "") " + (modalBar?.measurementUnit ?? "")
            lblGrossWt.text = "\(modalBar?.grossWeight ?? "") " + (modalBar?.measurementUnit ?? "")
        }
        if (modalBar?.website?.isEmpty ?? false) && modalBar?.website != "" {
            self.btnWebsite.isHidden = false
        }
        else{
            self.btnWebsite.isHidden = true
        }
        
    }
    
    @IBAction func btnProductWebsite(_ sender: AnyObject) {
        
        if (modalBar?.website?.isEmpty ?? false) {
            UIApplication.shared.openURL(NSURL(string: ("http://\((modalBar?.website)!)"))! as URL)
        }else{
            let alert = UIAlertController(title: "Sorry", message: "Website Url not Found", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    

}
