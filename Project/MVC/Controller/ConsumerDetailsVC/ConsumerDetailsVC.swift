//
//  ConsumerDetailsVC.swift
//  DataKart
//
//  Created by Aseem 13 on 12/12/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class ConsumerDetailsVC: BaseViewController {
    
    var modalBar : BarcodeModal?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    func setupUI(){
        
        lblName.text = modalBar?.consumerName
        lblEmail.text = modalBar?.consumerEmail
        lblContactNumber.text = modalBar?.consumerNumber
        lblAddress.text = modalBar?.consumerAddress
    }
    
    

}
