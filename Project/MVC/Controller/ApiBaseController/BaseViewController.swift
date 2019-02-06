//
//  ApiBaseClass.swift
//  DataKart
//
//  Created by Aseem 13 on 23/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import HCSStarRatingView
import SwiftyJSON

protocol DelegateFromBaseController {
    func updateSearchRecords()
}


let kMainQueue = DispatchQueue.main

let urlGtin = "https://gs1datakart.org/api/v5/products.q(format=json;gtin="
let urlCompany = "https://gs1datakart.org/gepir_new/companyinfo.php?gtin="

class BaseViewController: UIViewController, SJSegmentedViewControllerDelegate {

    var delegate : DelegateFromBaseController?
    var dict = [String : String]()
    let segmentedViewController = SJSegmentedViewController()
    var viewController : SJSegmentedViewController?
    var manuController :ManufacturerController?
    var secondViewController : ManufacturerVC?
    var count = Int()
    var phone = String()
    var NoProductFound = Bool()
    
    let ratingView = (UINib(nibName: "RatingView", bundle: nil).instantiate(withOwner:nil, options: nil) [0] as? RatingView)
    var rating = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.showSharePopUP()
    }
    
   
    
    func getGtinNumber(gtinNumber : String , controller : UIViewController )  {
        
        let dict = ["apiId" : "a678a9f658507c000ae41ec9d5969c40" , "apiKey" : "f5b127fd16af2efe5fb4b2396c371697"]
        SharedClass.shared.loaderGif ()
        let uniqueId = UIDevice.current.identifierForVendor!.uuidString
        APIManager().getWebRequest(urlString:"\(urlGtin)\(gtinNumber);imei=\(uniqueId);latitude=\(0);longitude=\(0)))",key : "ProductsApi", Parameters : dict as [String : AnyObject], successResponse: { (success) in
            
            if let arrayModal = success as? [BarcodeModal]{
            SharedClass.shared.removeLoader()
                if arrayModal.count > 0{
                    let modal = arrayModal[0]
                     print(modal.licNo)
                    self.viewController = self.getSJSegmentedViewController(modal: modal , controller: controller)
                    if self.viewController != nil {
        
                        kMainQueue.async {
                            controller.navigationController?.pushViewController(self.viewController!,
                                animated: true)
                        }
                    }
                    
                    self.NoProductFound = false
                    
                    if !(modal.manufacturerName == ""){
                        self.dict["companyName"] = modal.manufacturerName
                        self.getContactDetails(gtinNumber: gtinNumber,controller: controller)
                    }
                    
                } else{
                    
                    self.NoProductFound = true
                    self.getContactDetails(gtinNumber: gtinNumber,controller: controller)
                    SharedClass.shared.removeLoader()
                    
                 }
            }
            
        },failureResponse: { (failure) in
            print(failure)
            SharedClass.shared.removeLoader()
            self.showAlert(msg: "Some Error Occured !!",title: "Oops !!", controller: controller)
        })

    }
    
    func getContactDetails(gtinNumber : String, controller  : UIViewController) {
//        8901764061257
        
        if self.NoProductFound == true{
            self.manuController = controller.storyboard!.instantiateViewController(withIdentifier: "ManufacturerController") as? ManufacturerController
        }
        
        APIManager().getWebRequest(urlString: "\(urlCompany)\(gtinNumber)",key : "ContactApi",Parameters: [:], successResponse: { (modal) in
            
            if let modal2 = modal as? ContactModal{
                
                if !((modal2.name?.isEmpty)!){
                    if self.NoProductFound == true{
                        self.manuController?.setDataModal(modal: modal2)
                        controller.navigationController?.pushViewController(self.manuController!,
                            animated: true)
                    }else{
                        self.secondViewController?.getDataFromModal(modal: modal2)
                        self.dict["companyName"] = modal2.name
                        let df = DateFormatter()
                        df.dateFormat = "dd-MM-yyyy"
                        df.locale = .current
                        df.timeZone = .current
                        self.dict["savedTime"] = df.string(from: Date())

                        self.saveProductSearched(dict: self.dict)
                    }
                    
                    
                }else if modal2.code == "validation" || modal2.code == "checkdigit"{
                    self.showAlert(msg: "Invalid number",title: "Sorry", controller: controller)
                }else if self.NoProductFound == true{
                    self.showAlert(msg: "Product details and images not provided by manufacturer in DataKart",title: "Sorry", controller: controller)
                }else{
                    if (self.dict["companyName"]) != nil{
                        let df = DateFormatter()
                        df.dateFormat = "dd-MM-yyyy"
                        df.locale = .current
                        df.timeZone = .current
                        self.dict["savedTime"] = df.string(from: Date())
                        self.saveProductSearched(dict: self.dict)
                    }
                }
                
            }
            else{
                
                SharedClass.shared.removeLoader()
                self.showAlert(msg: "No records Found",title: "Sorry", controller: controller)
                
            }
            
            },failureResponse: { (failure) in
                print(failure)
                SharedClass.shared.removeLoader()
        })
        
    }
    
    func showAlert(msg : String,title: String, controller : UIViewController) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func getSJSegmentedViewController(modal : BarcodeModal? , controller : UIViewController) -> SJSegmentedViewController? {
        
        if let storyboard = controller.storyboard {
            
           
            SharedClass.shared.fssai_url = modal?.fssai_url
            SharedClass.shared.fsaai_licNo = modal?.licNo
            
           
            let headerViewController = storyboard.instantiateViewController(withIdentifier: "HeaderVC") as? HeaderVC
            headerViewController?.getDataFromModal(modal: modal!)
            
            let firstViewController = storyboard.instantiateViewController(withIdentifier: "AttributesVC") as? AttributesVC
            firstViewController?.title = "Basic Product Information"
            firstViewController?.getDataFromModal(modal: modal!)
            let firstViewController1 = storyboard.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
            firstViewController1?.title = "Product Detail Information"
            firstViewController1?.getDataFromModal(modal: modal!)
            secondViewController = storyboard.instantiateViewController(withIdentifier: "ManufacturerVC") as? ManufacturerVC
            secondViewController?.title = "Name & Address"
            secondViewController?.getDetailsFromBarcode(modal: modal!)
            
            let fourthViewController = storyboard.instantiateViewController(withIdentifier: "MRPController") as? MRPController
            fourthViewController?.title = "MRP"
            fourthViewController?.isBEE = false
            fourthViewController?.getDataFromModal(modal: modal!)
            
            let fourthViewController1 = storyboard.instantiateViewController(withIdentifier: "GSTViewController") as? GSTViewController
            fourthViewController1?.title = "GST"
            fourthViewController1?.getDataFromModal(modal: modal!)
            
            let fifthViewController = storyboard.instantiateViewController(withIdentifier: "RegulatoryDataVC") as? RegulatoryDataVC
            fifthViewController?.title = "FSSAI"
            fifthViewController?.getDataFromModal(modal: modal!)
            
            let sixthViewController = storyboard.instantiateViewController(withIdentifier: "ConsumerDetailsVC") as? ConsumerDetailsVC
            sixthViewController?.title = "Consumer Care Details"
            sixthViewController?.getDataFromModal(modal: modal!)
            
            let seventhViewController = storyboard.instantiateViewController(withIdentifier: "MRPController") as? MRPController
            seventhViewController?.title = "BEE"
            seventhViewController?.isBEE = true
            seventhViewController?.getDataFromModal(modal: modal!)
            
            let eigthViewController = storyboard.instantiateViewController(withIdentifier: "BISViewController") as? BISViewController
            eigthViewController?.title = "BIS"
            eigthViewController?.getDataFromModal(modal: modal!)
            
            let ninthViewController = storyboard.instantiateViewController(withIdentifier: "MRPController") as? MRPController
            ninthViewController?.title = "Agmark"
            ninthViewController?.isAgmark = true
            ninthViewController?.getDataFromModal(modal: modal!)
            
            var arrayControllers = [secondViewController!,firstViewController!,
                                    fourthViewController!,
                                    fourthViewController1!,fifthViewController!,sixthViewController!]
            
//            if let fssaiLicNo = modal?.licNo where !fssaiLicNo.isEmpty{
//                
//                arrayControllers = [secondViewController!,firstViewController!,
//                 fourthViewController!,fifthViewController!,sixthViewController!]
//            }
            
            
            if let beeArray = modal?.beeArray, beeArray.count > 0{
                
                arrayControllers = [secondViewController!,firstViewController!,
                                    fourthViewController!,
                                    fourthViewController1!,fifthViewController!,sixthViewController!,seventhViewController!]
            }
            
            if let agmarkArray = modal?.agmarkArray, agmarkArray.count > 0{
                
                if let beeArray = modal?.beeArray, beeArray.count > 0{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,seventhViewController!,ninthViewController!]
                }else{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,ninthViewController!]
                }
               
            }
          
            if let isiNo = modal?.isiNo, !isiNo.isEmpty{
                
                if let agmarkArray = modal?.agmarkArray, agmarkArray.count > 0, let beeArray = modal?.beeArray, beeArray.count > 0{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,seventhViewController!,eigthViewController!,ninthViewController!]
                }
                
                if let beeArray = modal?.beeArray, beeArray.count > 0{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,seventhViewController!,eigthViewController!]
                }
                else if let agmarkArray = modal?.agmarkArray, agmarkArray.count > 0{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,eigthViewController!,ninthViewController!]
                    
                }else{
                    
                    arrayControllers = [secondViewController!,firstViewController!,
                                        fourthViewController!,
                                        fourthViewController1!,fifthViewController!,sixthViewController!,eigthViewController!]
                }
                
                
            }
            
            if modal?.storageCondition != nil && modal?.storageCondition != ""{
                arrayControllers.insert(firstViewController1!, at: 2)
            }
            if arrayControllers.contains(ninthViewController!) && (modal?.agmarkArray?.last!["ca_number"] == nil || modal?.agmarkArray?.last!["ca_number"] == ""){
                let index = arrayControllers.lastIndex(where: { (vc) -> Bool in
                    vc == ninthViewController
                })
                if index != nil{
                arrayControllers.remove(at: index!)
                }
                
                }
            segmentedViewController.headerViewController = headerViewController
            segmentedViewController.segmentControllers = arrayControllers

            if modal?.ImagesArray?.count == 0 && (modal?.video_url == nil || modal?.video_url == ""){
            segmentedViewController.headerViewHeight = 72
            }
            else{
            segmentedViewController.headerViewHeight = 300
            }
//            segmentedViewController.setValue = modal?.mrpInfo?.count ?? 0
//            segmentedViewController.setValue = modal?.beeArray?.count ?? 0
            
            segmentedViewController.selectedSegmentViewColor = UIColor(red: 222.0/255.0, green: 81.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            
            
            segmentedViewController.segmentViewHeight = 40.0
            segmentedViewController.headerViewOffsetHeight = 72
            segmentedViewController.segmentShadow = SJShadow.light()
            segmentedViewController.delegate = self
            
            
            dict["index"] = "1"
            dict["image"] = modal?.ImageFront
            dict["productName"] = modal?.name
            dict["gtinNumber"] = modal?.gtinNo
            dict["desc"] = modal?.desct
            
            
            UserDefaults.standard.set(dict, forKey: "ProductInfo")
            
            return segmentedViewController
        }
        
        return nil
    }
    
    func saveProductSearched(dict : [String : String]){
        
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("PreviousSearches")
        
        if let Array : NSArray = UserDefaults.standard.object(forKey: "PreviousSearches") as? NSArray{
            
            var savedArray : [AnyObject] = Array as [AnyObject]
            
            if savedArray.count == 10 {
                savedArray.removeFirst()
            }
            updateArray(saved: savedArray)
            
        }else{
            UserDefaults.standard.set([dict], forKey: "PreviousSearches")
        }
        
        delegate?.updateSearchRecords()
        
    }
    
    
    func updateArray (saved : [AnyObject])  {
        
        var savedArray : [AnyObject] = saved as [AnyObject]
        var arrayGtinNumbers = [String]()
        
        for dict2 in savedArray {
            let str = dict2["gtinNumber"] as! String
            arrayGtinNumbers.append(str)
        }
        
        let str = dict["gtinNumber"]
        if NoProductFound == false {
            if !(arrayGtinNumbers.contains(str!)) {
                savedArray.append(dict as AnyObject)
                UserDefaults.standard.set(savedArray, forKey: "PreviousSearches")
                
            }
        }
        
    }
}

extension BaseViewController {
    
    
    
    func didMoveToPage(controller: UIViewController, segment: UIButton?, index: Int , height : Int) {
        
        if segmentedViewController.segments.count > 0 {
            
            let button = segmentedViewController.segments[index]
            button.titleColor(UIColor(red: 222.0/255.0, green: 81.0/255.0, blue: 33.0/255.0, alpha: 1.0))
            
        }
    }
    
    
    func didSelectSegmentAtIndex(index: Int) {
        
    }
    
}


extension BaseViewController {
    
    @IBAction func btnSubmitFeedback(_ sender: AnyObject) {
        
        if let ratingView = ratingView{
            ratingView.frame = (appDelegate.window?.frame)!
            appDelegate.window?.addSubview(ratingView)
            ratingView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            UIView.animate(withDuration: 0.0, delay: 0, options: .curveEaseOut, animations: {() -> Void in
                ratingView.transform = .identity
                }, completion: {(finished: Bool) -> Void in
                    // do something once the animation finishes, put it here
            })
            
            
//            ratingView.ratingView.delegate = self
            ratingView.ratingView.addTarget(self, action: #selector(ratingUpdated(sender:)), for: .valueChanged)
            ratingView.submitBtn.addTarget(self,action:#selector(ratingSubmitted(sender:)),
                                           for:.touchUpInside)
        }
        
    }
    @objc func ratingUpdated(sender:Any){
        if ratingView != nil {
            rating = ratingView?.ratingView.value ?? 0.0
            print(rating)
        }
    }
    
    @objc func ratingSubmitted(sender:UIButton){
        print(rating)
        if(rating <= 3){
            
            ratingView?.removeFromSuperview()
            FeedbackBaseController().showFeedbackForm(controller: self)
            SharedClass.shared.ratingSubmitted = rating
            ratingView?.ratingView.value = 0.0
            
            
            
        }
        else{
            ratingView?.removeFromSuperview()
            self.submitRating(rating: rating)
            ratingView?.ratingView.value = 0.0
        }
        
        
    }

    
    
    func submitRating(rating : CGFloat) {
        
        guard let dictInfo = UserDefaults.standard.object(forKey: "ProductInfo") as? NSDictionary else {return}
        guard let productDesc = dictInfo["desc"],let gtin = dictInfo["gtinNumber"],let productName = dictInfo["productName"] else {return}
        
        let dict : [String : AnyObject] = ["email_id":"No email" as AnyObject, "batch_no" : "-" as AnyObject,"contact_no":"-" as AnyObject,"complaint":"kjnk" as AnyObject, "complaint_id": "0" as AnyObject,"gtin":gtin as AnyObject,"product_desc": productDesc as AnyObject ,"product_name" : productName as AnyObject,"rating" :rating as AnyObject]
        
        
        APIManager().postWebRequest(urlString: "https://gs1datakart.org/api/v5/feedback?apiId=df4a3e288e73d4e3d6e4a975a0c3212d&apiKey=440f00981a1cc3b1ce6a4c784a4b84ea", Parameters: dict, successResponse: { (response) in
            
            SharedClass.shared.removeLoader()
            self.showAlert(msg: "Thankyou for your feedback")
            
            },failureResponse: { (failure) in
                print(failure)
                SharedClass.shared.removeLoader()
        })
    }
    
    
    func showAlert(msg : String)  {
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
            
        })
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
