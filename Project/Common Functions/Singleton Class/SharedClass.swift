//
//  SharedClass.swift
//  HutchDecor
//
//  Created by Aseem 13 on 14/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class SharedClass: NSObject {
    
    var appDelegate = AppDelegate()
    var overlayView = UIView()
    var ViewToBeMoved = UIView()
    var activityView = UIActivityIndicatorView()
    var reachability : Reachability?
    var ratingSubmitted : CGFloat?
    var fssai_url :String?
    var fsaai_licNo : String?
    
    override init() {
       super.init()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        GiFHUD.setGif("loader.gif")
    }
    
    static let shared = SharedClass()
    
    func Loader(){
        
//        appDelegate.window?.addSubview(overlay())
//        activityView = UIActivityIndicatorView(style: .gray)
//        activityView.center = overlayView.center
//        activityView.startAnimating()
//        appDelegate.window?.addSubview(activityView)
    }
    func loaderGif()  {
//         GiFHUD.show()
        
        kAppDelegate.showLoaderWith()
    }
    func loaderWhiteOverlay(){
//        GiFHUD.showWithOverlay()
    }
    func removeLoader(){
        kAppDelegate.hideLoader()
        
        
        overlayView.removeFromSuperview()
        activityView.removeFromSuperview()
//        GiFHUD.dismiss()
    }
   
    func overlay() {
        
//        overlayView = UIView.init(frame: (appDelegate.window?.frame)!)
//        overlayView.backgroundColor = UIColor.black
//        overlayView.alpha = 0
//        UIView.animate(withDuration: 0.3) {
//            self.overlayView.alpha = 0.3
//        }
//
//        return overlayView
    }
    
    
    func addCorners(cornerRadius : CGFloat, borderWidth : CGFloat, borderColor : UIColor, view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = borderColor.cgColor
    }
    
    
    func addBounce(view : UIView)  {
        UIView.animate(withDuration: 0.3/1.5, animations: {
            view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)// CGAffineTransformScale(.identity, 1.2, 1.2)
            }) { (finished) in
                UIView.animate(withDuration: 0.3/2, animations: {
                    view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0) //CGAffineTransformScale(.identity, 1.0, 1.0)
                    }, completion: { (finished) in
                        UIView.animate(withDuration: 0.3/2, animations: {
                            view.transform = .identity
                        })
                })
        }
    }
    
    func checkInternet(showToast: Bool = true) -> Bool {
        let connection = reachability?.connection
        switch connection {
        case .cellular?:
            print("internet connected: cellular")
            return true
        case .none:
            print("internet not connected: None")
            return false
        case .wifi?:
            print("internet connected: wifi")
            return true
        case .some(.none):
            print("internet not connected: None")
            return false
        }
    }
    
    func checkForReachability(){
        
    }
    
    func reachabilityChanged(note: NSNotification) {
        
        
    }
    
//    func getCoordinates(){
//        if (appDelegate.latitude == nil) {
//            let location = LocationManager.sharedInstance.currentLoc
//            appDelegate.latitude = location?.coordinate.latitude
//            appDelegate.longitude = location?.coordinate.longitude
//        }
//        print("\(appDelegate.latitude)  \(appDelegate.longitude)")
//    }
    
   
    
}


extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

