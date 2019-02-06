//
//  BISViewController.swift
//  JagrukGrahak
//
//  Created by OSX on 06/02/18.
//  Copyright © 2018 Taran. All rights reserved.
//

import UIKit

class BISViewController: BaseViewController {

    @IBOutlet weak var lblISINumber: UILabel!
    var modalBar : BarcodeModal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    
    func setupUI(){
        
        lblISINumber?.text = modalBar?.isiNo
        
    }
    
}
