//
//  WebViewVC.swift
//  DataKart
//
//  Created by Aseem 13 on 03/11/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var lblText: UILabel!
    var strLbl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblText.text  = strLbl
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
