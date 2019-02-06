//
//  ASShareView.swift
//  SmartConsumer
//
//  Created by Mr. X on 05/12/18.
//  Copyright © 2018 Ankit_Saini. All rights reserved.
//

import UIKit

class ASShareView: UIView {

    @IBOutlet weak var uvPopUp: UIView!
    @IBOutlet weak var btnShare: UIButton!
    
    
    //MARK:- INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame)
        let uvNub: UIView = (Bundle.main.loadNibNamed("ASShareView", owner: self, options: nil)![0] as? UIView)!
        uvNub.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(uvNub)
        
        uvPopUp.layer.cornerRadius = 10.0
        uvPopUp.layer.masksToBounds = true
        
        
        btnShare.addTarget(self, action: #selector(actShareNow), for: .touchUpInside)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actShareNow() {
        kAppDelegate.shareOnSocial(title: "https://itunes.apple.com/in/app/smart-consumer/id1186685533?mt=8", image: nil)
        self.removeFromSuperview()
    }

    @IBAction func actBgButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
