//
//  QQScanViewController.swift
//  swiftScan
//
//  Created by xialibing on 15/12/10.
//  Copyright © 2015年 xialibing. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

//protocol DelegateFromBarCodeController {
//    func updateSearchRecords()
//}


class QQScanViewController: UIViewController, SJSegmentedViewControllerDelegate, DelegateFromBaseController {
    func updateSearchRecords() {
        
    }
    
    
    let segmentedViewController = SJSegmentedViewController()
    var viewController : SJSegmentedViewController?
    var homeController : HomeScreenVC?
    
//    var delegate : DelegateFromBarCodeController?
    var topTitle:UILabel?
    var isOpenedFlash:Bool = false

    var bottomItemsView:UIView?
    var btnPhoto:UIButton = UIButton()
    var btnFlash:UIButton = UIButton()
    var btnMyQR:UIButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setNeedCodeImage(true)
//        scanStyle?.centerUpOffset += 10

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(animated: Bool) {
//
//        super.viewDidAppear(animated)
//
//        drawBottomItems()
//    }
    
    /*
    func drawBottomItems()
    {
        if (bottomItemsView != nil) {
            
            return;
        }
        
        let yMax = CGRectGetMaxY(self.view.frame) - CGRectGetMinY(self.view.frame)
        
        bottomItemsView = UIView(frame:CGRectMake( 0.0, yMax-100,self.view.frame.size.width, 100 ) )
        
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        
        let size = CGSizeMake(90, 79);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRectMake(0, 0, size.width, size.height)
        btnFlash.center = CGPointMake(CGRectGetWidth(bottomItemsView!.frame)/2, CGRectGetHeight(bottomItemsView!.frame)/2)
        btnFlash.setImage(UIImage(named: "ic_flash"), forState:UIControlState.Normal)
        btnFlash.addTarget(self, action: #selector(QQScanViewController.openOrCloseFlash), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPointMake(CGRectGetWidth(bottomItemsView!.frame)/4, CGRectGetHeight(bottomItemsView!.frame)/2)
        btnPhoto.setImage(UIImage(named: "ic_choose_photo"), forState: UIControlState.Normal)
        btnPhoto.setImage(UIImage(named: "ic_choose_photo_fill"), forState: UIControlState.Highlighted)
        btnPhoto.addTarget(self, action: #selector(openPhotoAlbum), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        self.btnMyQR = UIButton()
        btnMyQR.bounds = btnFlash.bounds;
        btnMyQR.center = CGPointMake(CGRectGetWidth(bottomItemsView!.frame) * 3/4, CGRectGetHeight(bottomItemsView!.frame)/2);
        btnMyQR.setImage(UIImage(named: "ic_cancel"), forState: UIControlState.Normal)
        btnMyQR.setImage(UIImage(named: "ic_cancel_fill"), forState: UIControlState.Highlighted)
        btnMyQR.addTarget(self, action: #selector(QQScanViewController.myCode), forControlEvents: UIControlEvents.TouchUpInside)
        
        bottomItemsView?.addSubview(btnFlash)
        bottomItemsView?.addSubview(btnPhoto)
        bottomItemsView?.addSubview(btnMyQR)
        self.view .addSubview(bottomItemsView!)
        
    }
    
    //开关闪光灯
    func openOrCloseFlash()
    {
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash
        {
            btnFlash.setImage(UIImage(named:"ic_flash_fill"), forState:UIControlState.Normal)
        }
        else
        {
            btnFlash.setImage(UIImage(named:"ic_flash"), forState:UIControlState.Normal)
        }
    }
    
    func myCode()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result:LBXScanResult in arrayResult
        {
            print("%@",result.strScanned)
        }
        
        let result:LBXScanResult = arrayResult[0]
        
        let baseController = BaseViewController()
        baseController.delegate = self
        baseController.getGtinNumber(result.strScanned! , controller: homeController!)

        
    }
    
    
    func updateSearchRecords(){
        
//        delegate?.updateSearchRecords()
    }


*/
}
