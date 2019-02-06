//
//  GSTViewController.swift
//  SmartConsumer
//
//  Created by Abhishek Rana on 01/02/19.
//  Copyright © 2019 Ankit_Saini. All rights reserved.
//

import UIKit

class GSTViewController: UIViewController {
 var modalBar : BarcodeModal?
    @IBOutlet weak var lblHsCode: UILabel!
    @IBOutlet weak var lblIgst: UILabel!
    @IBOutlet weak var lblSgst: UILabel!
    @IBOutlet weak var lblCgst: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    

    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    
    func setupUI(){
        
        lblHsCode?.text = modalBar?.hsCode
        lblIgst?.text = modalBar?.igst

        lblSgst?.text = modalBar?.sgst

        lblCgst?.text = modalBar?.cgst

    }
    

}
