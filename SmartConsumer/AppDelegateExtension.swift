//
//  AppDelegateExtension.swift
//  LowRateInsuranceAgency
//
//  Created by softobiz on 12/7/17.
//  Copyright © 2017 Ankit_Saini. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension AppDelegate {
    
    func openInSafariURL(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func makeCall(number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    // MARK:-
    // MARK: Loading Indivaror
    // MARK:
    
    /**
     * @Author : Ankit Saini on 07/12/2017 v1.0
     *
     * Function name: showLoaderWith & hideLoader
     *
     * @description:  This function is used to show the spinning loader on view and hide the loader from the view.
     *
     * @param : title: String = "" => This will be written under the loader,
     *          interaction: Bool = true => This will disable the user interaction to app if true.
     */
    
    func showLoaderWith(title: String = "Loading", interaction: Bool = false) {
        if interaction == false {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        SVProgressHUD.show(withStatus: title)
    }
    
    func changeLoaderText(title: String = "") {
        kMainQueue.async {
            SVProgressHUD.setStatus(title)
        }
    }
    
    func hideLoader() {
        kMainQueue.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK:-
    // MARK: Reachability
    // MARK:
    
    /**
     * @Author : Ankit Saini on 07/12/2017 v1.0
     *
     * Function name: checkInternet
     *
     * @description:  This function is used to check the internet is available or not. Return bool to controll further processings.
     *
     */
    
    func checkInternet(showToast: Bool = true) -> Bool {
        let connection = reachability.connection
        switch connection {
        case .cellular:
            print("internet connected: cellular")
            return true
        case .none:
            if showToast == true {
                kMainQueue.async {
                    //ASUtility.sharedInstance.showToast(strMsg: L10n.noInternet.string)
                    print("internet not connected")
                }
            }
            print("internet not connected: None")
            return false
        case .wifi:
            print("internet connected: wifi")
            return true
        }
    }
    
    
    func shareOnSocial(title: String?, image: UIImage?) {
        // text to share
        
        var arrData: [Any] = []
        
        if title != nil {
            arrData.append(title as Any)
        }
        
        if image != nil {
            arrData.append(image as Any)
        }
        
        // set up activity view controller
        
        let activityViewController = UIActivityViewController(activityItems: arrData, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = kAppDelegate.window?.rootViewController?.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        kAppDelegate.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func showSharePopUP() {
        if let data = Defaults.value(forKey: kPopTime) as? String{
            let lastDate = Date.init(fromString: data, format: .isoDateTime)
            if lastDate != nil{
                if lastDate!.compare(.isToday) == true{
                    print("Saved date is today.")
                    return
                }
            }
        }
        
        Defaults[kPopTime] = Date().toString(format: .isoDateTime)
        
        if upSharePopUP == nil{
            upSharePopUP = ASShareView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight))
        } else{
            upSharePopUP?.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        }
        kAppDelegate.window?.rootViewController?.view.addSubview(upSharePopUP!)
        
    }
    
    // MARK:-
    // MARK: Splash Handling
    // MARK:
    
    /**
     * @Author : Ankit Saini on 07/12/2017 v1.0
     *
     * Function name: createSplash
     *
     * @description:  This function is used to show the custom splash screen at app launch.
     *
     * Function name: removeSplash
     *
     * @description:  This function is used to remove splash from the superview
     *
     * Function name: addNotifications
     *
     * @description:  This function is used to observe the splash removal notification.
     *
     */
    
    func createSplash() {
        if objSplash == nil {
            objSplash = ASplash.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight))
        }
        self.window?.rootViewController?.view.addSubview(objSplash!)
    }
    
    @objc func removeSplash() {
        if objSplash != nil {
            objSplash?.removeFromSuperview()
            objSplash = nil
        }
        self.showSharePopUP()
    }
    
    func addNotifications() {
        kDefaultCenter.removeObserver(self, name: Notifications.splashRemove.name, object: nil)
        kDefaultCenter.addObserver(self, selector: #selector(removeSplash), name: Notifications.splashRemove.name, object: nil)
    }
}
