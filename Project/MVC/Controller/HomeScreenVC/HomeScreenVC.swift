//
//  HomeScreenVC.swift
//  DataKart
//
//  Created by Aseem 13 on 20/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import SwiftyJSON
//import Crashlytics
import BarcodeScanner

class HomeScreenVC: UIViewController , DelegateFromBaseController , DelegateFromBarCodeController{
    
    @IBOutlet weak var lblPreviousSearches: UILabel!
    var dict = [String : String]()
    var modalSaved : BarcodeModal?
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var txtBarcodeNo: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    var datasource : TableViewDataSource?
    var array = [AnyObject]()
//    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
      txtBarcodeNo.text = "8906103950070"
         self.animateShareButton()
    }
    
//    func update(){
//        if appDelegate.latitude == nil {
//            SharedClass.shared.getCoordinates()
//        }
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupUI() {
        
//         timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(RegistrationController.update), userInfo: nil, repeats: true)
        
        lblPreviousSearches.isHidden = true
        if let Array : NSArray = UserDefaults.standard.object(forKey: "PreviousSearches") as? NSArray{
            
            array = Array as [AnyObject]
            lblPreviousSearches.isHidden = false
            setTableData()
        }else{
            lblPreviousSearches.isHidden = true
        }
       
    }
    func animateShareButton(){
        UIView.animate(withDuration: 0.5, animations: {
            self.btnShare.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.btnShare.alpha = 1
            }) { (_) in
                self.animateShareButton()
            }
        }
    }
    func setTableData() {
        
        datasource = TableViewDataSource(items: array, items2: nil, height: 102.0, tableView: tableView, cellIdentifier: "HomeCell", configureCellBlock: { (cell, item, item2, indexpath) in
            
            let dict : [String : String] = item as! [String : String]
            let cell2 = cell as? HomeCell
            cell2?.configureCell(dict: dict)
            
            }, aRowSelectedListener: { (indexPath, item) in
                
                let dict : [String : String] = item as! [String : String]
                self.didSelectCalled(indexPath: indexPath , item: dict["gtinNumber"])
                
        })
        tableView.dataSource = datasource
        tableView.delegate = datasource
        tableView.reloadData()
    }
    
    func didSelectCalled(indexPath : NSIndexPath , item : String?) {
        
        let baseController = BaseViewController()
        baseController.delegate = self
        
        baseController.getGtinNumber(gtinNumber: item! , controller: self)
    }
    
    @IBAction func btnSettings(_ sender: UIButton) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    @IBAction func actionShare(_ sender: Any) {
        kAppDelegate.shareOnSocial(title: "https://itunes.apple.com/in/app/smart-consumer/id1186685533?mt=8", image: nil)
    }
    @IBAction func btnGo(_ sender: UIButton) {
        if !(txtBarcodeNo.text!.isEmpty) {
            let baseController = BaseViewController()
            baseController.delegate = self
            baseController.getGtinNumber(gtinNumber: txtBarcodeNo.text! , controller: self)
        }else{
            let alert = UIAlertController(title: "Sorry", message: "Barcode Number Field is Empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func updateSearchRecords(){
        
        setupUI()
        
    }
    
    @IBAction func btnScanBarCode(_ sender: UIButton) {
        
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
        
        
        return
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BarcodeReaderViewController") as? BarcodeReaderViewController
//        vc?.homeController = self
//        vc?.delegate = self
//        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    
    @IBAction func btnLink(_ sender: Any) {
        kAppDelegate.openInSafariURL(url: "http://www.gs1india.org/datakart")
    }
}


// MARK: - BarcodeScannerCodeDelegate

extension HomeScreenVC: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
      //  controller.reset()
        kMainQueue.asyncAfter(deadline: .now()+0.1) {
            controller.dismiss(animated: true, completion: nil)
            
            let baseController = BaseViewController()
            baseController.delegate = self
            //        baseController.getGtinNumber(barcode.stringValue , controller: self)
            let sortedCode = self.convertString(text: code).StringByEscapingCharacters()
            baseController.getGtinNumber(gtinNumber:sortedCode, controller: self)
        }
        
        
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            controller.resetWithError()
//        }
    }
    func convertString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        return String(text.filter {okayChars.contains($0) })
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension HomeScreenVC: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension HomeScreenVC: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
