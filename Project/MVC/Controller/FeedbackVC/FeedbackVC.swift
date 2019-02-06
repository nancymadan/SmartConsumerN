//
//  FeedbackVC.swift
//  DataKart
//
//  Created by Aseem 13 on 14/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON
import HCSStarRatingView
import DropDown
import SafariServices

class FeedbackVC: UIViewController,UITextFieldDelegate{

    var front = Bool()
    
    var modal1 = BarcodeModal()
    
    var strBase64Front : String?
    var strBase64Back : String?
    
    let items: [String] = [ "Food Safety and Quality", "MRP", "Net Content", "Label Information", "Energy Rating", "Others"]
    
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet var btnAreaOfConcern: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet var txtAreaOfConcern: UITextField!
    @IBOutlet var btnTypeCollection: [UIButton]!
    @IBOutlet weak var img_Camera1: UIImageView!
    @IBOutlet weak var lblFront: UILabel!
    
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var txtBatchNumber: UITextField!
    
    @IBOutlet weak var img_Camera2: UIImageView!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var imageViewBack: UIImageView!
    @IBOutlet weak var imageViewFront: UIImageView!
    
    @IBOutlet weak var viewSelectState: UIView!
    @IBOutlet var ratingView: HCSStarRatingView!
    
    @IBOutlet var txtName: UITextField!
    var dropDown = DropDown()
    var product_type : String?
    var concern_area : String?
    var user_name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FeedbackVC.callFrontImagePicker))
        imageViewFront.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(FeedbackVC.callBackImagePicker))
        imageViewBack.addGestureRecognizer(tapGesture2)
        SharedClass.shared.addCorners(cornerRadius: 5.0, borderWidth: 1.0, borderColor: UIColor.clear, view: imageViewFront)
        SharedClass.shared.addCorners(cornerRadius: 5.0, borderWidth: 1.0, borderColor: UIColor.clear, view: imageViewBack)
        
        SharedClass.shared.addCorners(cornerRadius: 4.0, borderWidth: 1.0, borderColor: UIColor.lightGray, view: btnAreaOfConcern)
        
        imageViewBack.layer.masksToBounds = true
        imageViewFront.layer.masksToBounds = true
        txtComment.delegate = self
        txtMobileNumber.delegate = self
        txtPinCode.delegate = self

        if let rating = SharedClass.shared.ratingSubmitted {
        ratingView.value =  rating
           
        }
        // Do any additional setup after loading the view.
        self.viewSelectState.layer.borderColor = UIColor.gray.cgColor
        self.viewSelectState.layer.borderWidth = 1
    }

    @IBAction func areaOfConcern(_ sender: UIButton) {
       setupDropDown()
       dropDown.show()
    }
    func setupDropDown() {
        dropDown.dataSource = items
        dropDown.direction = .bottom
        dropDown.anchorView = btnAreaOfConcern
        dropDown.bottomOffset = CGPoint(x: 0, y:50)
        dropDown.selectionAction = {(index: Int, item: String) in
            self.txtAreaOfConcern.text = self.items[index]
            self.concern_area = self.items[index]
        }
    }
    
    @IBAction func selectFoodType(_ sender: UIButton) {
        switch sender{
        case btnTypeCollection[0]:
            btnTypeCollection[1].setImage(UIImage(named: "ic_radio_button_unchecked_white"), for:UIControl.State.normal)
            btnTypeCollection[0].setImage(UIImage(named: "ic_radio_button_checked_white"), for:UIControl.State.normal)
            product_type = "Food"
            
        case btnTypeCollection[1]:
            btnTypeCollection[0].setImage(UIImage(named: "ic_radio_button_unchecked_white"), for:UIControl.State.normal)
            btnTypeCollection[1].setImage(UIImage(named: "ic_radio_button_checked_white"), for:UIControl.State.normal)
             product_type = "Non-Food"
            
        default :
            print("Nothing")
            
        }

    }
    
//    func starRatingView(starRatingView: WDStarRatingView, didUpdateToValue value: CGFloat){
//        print("value is ",value)
//        ratingView.value = value
//    }
    
    @objc func callFrontImagePicker(){
        
        SharedClass.shared.addBounce(view: imageViewFront)
        
        front = true
        ImagePickerController.sharedInstance.addPicture(controller: self)
        
    }
    
    @objc func callBackImagePicker(){
        
        SharedClass.shared.addBounce(view: imageViewBack)
        
        front = false
        ImagePickerController.sharedInstance.addPicture(controller: self)
    }
    
    func getImage(image : UIImage){
        
        if front {
            imageViewFront.image = image
            img_Camera1.isHidden = true
            lblFront.isHidden = true
            strBase64Front = convertToBase64(image: image)
        } else{
            imageViewBack.image = image
            img_Camera2.isHidden = true
            lblBack.isHidden = true
            strBase64Back = convertToBase64(image: image)
        }
    }
    
  

    func parametersDict() -> [String : AnyObject] {
       
        let dictInfo : NSDictionary = UserDefaults.standard.object(forKey: "ProductInfo") as! NSDictionary
        print(attachmentArray())
        let userName = txtName.text ?? ""
        let concernArea = concern_area ?? ""
        let productType = product_type ?? "Food"
        let rating = SharedClass.shared.ratingSubmitted ?? 0
        let dict:[String:AnyObject] = ["email_id":txtEmail.text! as AnyObject, "batch_no" : txtBatchNumber.text! as AnyObject,"contact_no":txtMobileNumber.text! as AnyObject, "complaint":txtComment.text! as AnyObject,"attachment" : attachmentArray(), "complaint_id": "0" as AnyObject,"gtin":dictInfo["gtinNumber"]! as AnyObject,"product_desc": dictInfo["desc"]! as AnyObject ,"product_name" : dictInfo["productName"]! as AnyObject,"user_name":userName as AnyObject,"concern_area":concernArea as AnyObject,"product_type":productType as AnyObject,"rating" : "\(rating)" as AnyObject,"state":self.btnSelectDate.title(for: .normal) as AnyObject,"pincode":self.txtPinCode?.text as AnyObject]
        return dict
    }
    
    func attachmentArray() -> AnyObject {
        
        let Dict : NSDictionary = UserDefaults.standard.object(forKey: "ProductInfo") as! NSDictionary
            
        let gtinNo = Dict["gtinNumber"]!
        
        
        if (strBase64Front != nil && strBase64Back != nil) {
            return [["name":"image.jpg","contentBytes":strBase64Front!],["name":"image2.jpg","contentBytes":strBase64Back!]] as AnyObject
        }else if strBase64Front != nil{
            return [["name":"image.jpg","contentBytes":strBase64Front!]] as AnyObject
        }else if strBase64Back != nil{
            return [["name":"image2.jpg","contentBytes":strBase64Back!]] as AnyObject
        }else{
            return "" as AnyObject
        }
        
    }
    
    func convertToBase64(image : UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 1.0)
        let strBase64:String = imageData!.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == txtComment){
            
            if(range.length + range.location > textField.text?.count ?? 0){
                return false;
            }
            
            let newLength = (textField.text?.count)! + string.count - range.length
            return newLength <= 150;
        }
        else if (textField == txtMobileNumber){
            
            if(range.length + range.location > textField.text?.count ?? 0){
                return false;
            }
            
            let newLength = (textField.text?.count)! + string.count - range.length
            return newLength <= 10;
        }

        return true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
     navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSelectState(_ sender: Any) {
        let arr = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"]
        let actionSheet = UIAlertController.init(title: "Select State", message: nil, preferredStyle: .actionSheet)
        for state in arr{
            actionSheet.addAction(UIAlertAction.init(title: state, style: .default, handler: { (_) in
                self.btnSelectDate.setTitle(state, for: .normal)
            }))
        }
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func btnSubmit(_ sender: AnyObject) {
        
        let value = ValidationClass().validateFeedback(batchNo: txtBatchNumber.text!, Comments: txtComment.text!, MobileNo:txtMobileNumber.text! , Email: txtEmail.text!,name: txtName.text!, state: self.btnSelectDate.title(for: .normal) ?? "",pincode: self.txtPinCode.text ?? "")
        
        if value == 0 {
            
           // SharedClass.shared.overlay()
            SharedClass.shared.loaderGif ()

            APIManager().postWebRequest(urlString: "https://gs1datakart.org/api/v5/feedback?apiId=df4a3e288e73d4e3d6e4a975a0c3212d&apiKey=440f00981a1cc3b1ce6a4c784a4b84ea", Parameters: parametersDict(), successResponse: { (response) in
                
                SharedClass.shared.removeLoader()
                
                let json =  JSON(response!)
                
                if json["success"][0].dictionaryValue.count > 0 {
                    
                    let msg = json["success"][0]["complaint_id"].stringValue
                    self.checkForFSSAIUrl(msg: msg)
                }
                else if json.stringValue != nil {
                    self.showAlert(msg: "\(json.stringValue)")

                }
                
                
                },failureResponse: { (failure) in
                    print(failure)
                    SharedClass.shared.removeLoader()
            })
            
        }
        
    }
    
    func checkForFSSAIUrl(msg : String){
        
        if((product_type == "Food")&&concern_area == "Food Safety and Quality"){
            
            guard let url = SharedClass.shared.fssai_url,let fssaiNo = SharedClass.shared.fsaai_licNo else{return}
            
            let str = url.appendingFormat("&cno=\(msg)&fssai=\(fssaiNo)")
            
            let svc = SFSafariViewController(url: NSURL(string: str ?? "")! as URL)
            
            self.present(svc, animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
            
        }
        else{
            showAlert(msg: "Your complaint reference number is \(msg)")
        }
        
        
       
        
    }
    
    
    
    func showAlert(msg : String,title:String? = nil)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            self.navigationController?.popViewController(animated: true)
            alert.dismiss(animated: true, completion: nil)
            
        })
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)

    }
}
