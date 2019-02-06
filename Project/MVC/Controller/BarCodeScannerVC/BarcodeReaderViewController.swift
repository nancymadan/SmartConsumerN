//
//  BarcodeReaderViewController.swift
//  JagrukGrahak
//
//  Created by Aseem 13 on 05/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import AVFoundation

protocol DelegateFromBarCodeController {
    func updateSearchRecords()
}

class BarcodeReaderViewController: UIViewController,DelegateFromBaseController {
    func updateSearchRecords() {
        
    }
    

    @IBOutlet weak var toggle: UIButton!
    var barcode: String = ""
    var dispatched: Bool = false
    var homeController : HomeScreenVC?
    var delegate : DelegateFromBarCodeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: #selector(BarcodeReaderViewController.update), userInfo: nil, repeats: true)
//
//        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
//        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
//
//        let types = NSMutableArray(array: self.output.availableMetadataObjectTypes)
//        self.output.metadataObjectTypes = NSArray(array: types) as [AnyObject]
//
//        self.toggle.enabled = self.hasTorch()
        
    }
    /*
    override func viewDidAppear(animated: Bool) {
        scanCode()
    }
    
    
    func scanCode(){
        self.barcodesHandler = { barcodes in
            if !self.dispatched { // triggers for only once
                self.dispatched = true
                for barcode in barcodes {
                    self.barcode = barcode.stringValue
                    print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let baseController = BaseViewController()
                        baseController.delegate = self
                        baseController.getGtinNumber(barcode.stringValue , controller: self)
                        
                    }
                    
                    break
                }
            }
        }

    }
    
    func update() {
        self.dispatched = false
    }

    func updateSearchRecords(){
        
        delegate?.updateSearchRecords()
    }*/

    @IBAction func btnToggle(_ sender: AnyObject) {
//        let isTorchOn = self.toggleTorch()
//        print(isTorchOn)
    }
    
    @IBAction func btnClose(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
