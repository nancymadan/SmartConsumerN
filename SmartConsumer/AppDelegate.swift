//
//  AppDelegate.swift
//  SmartConsumer
//
//  Created by Mr. X on 25/10/18.
//  Copyright © 2018 Ankit_Saini. All rights reserved.
//

import UIKit
import SDWebImage
import IQKeyboardManagerSwift

let kAppDelegate = (UIApplication.shared.delegate as! AppDelegate)
let kPopTime: String = "popTime"
let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

enum Notifications: String {
    
    case splashRemove = "splashRemove"
    var name : Notification.Name  {
        return Notification.Name(rawValue: self.rawValue )
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!

    var upSharePopUP: ASShareView?
    var objSplash: ASplash?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //---------------------------------------------------------------------
        //Enable Keyboard Manager
        //
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        ///
        /// Moved into remove splash method
//        self.showSharePopUP()
        
        //---------------------------------------------------------------------
        // Splash Screen
        //
        if let time = UserDefaults.standard.value(forKey: "SmartConsumerSplashTime")  as? Date{
            let components = Calendar.current.dateComponents([.hour], from: time, to: Date())
            let diff = components.hour!
            if diff < 24{
                return true
            }
        }
        UserDefaults.standard.set(Date(), forKey: "SmartConsumerSplashTime")
        createSplash()
        addNotifications()
   
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

