//
//  MarketingVC.swift
//  SmartConsumer
//
//  Created by Dev on 01/03/19.
//  Copyright © 2019 Ankit_Saini. All rights reserved.
//

import UIKit

class MarketingVC: UIViewController {
    var strMarketingTxt  = ""
    var txtMarketing : UITextView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtMarketing = UITextView.init(frame: CGRect.init(x: 20, y: 20, width: kWidth-40, height: kHeight-40))
        txtMarketing?.isEditable = false
        txtMarketing?.textColor = UIColor.black
        self.view.addSubview(txtMarketing!)
        txtMarketing?.text = strMarketingTxt
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtMarketing?.text = strMarketingTxt

    }
    func setData(txt:String){
        strMarketingTxt = txt
    }
   

}
