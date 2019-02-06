//
//  RootController.swift
//  DataKart
//
//  Created by Aseem 13 on 21/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class RootController: DLHamburguerViewController {

    var str = String()
    var value = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        
//        let regsiter = NSUserDefaults.standardUserDefaults().objectForKey("Registration") as? String
//        if regsiter != nil{
//            value = true
//        }
//        value == true ? (str = "NavigationController") : (str = "RegisterNavigationController")
        
        str = "NavigationController"
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: str) as! DLHamburguerNavigationController
        
        self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsSidebar") as! SettingsSidebar
        
       
    }
}
