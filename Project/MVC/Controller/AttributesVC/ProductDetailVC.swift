//
//  ProductDetailVC.swift
//  SmartConsumer
//
//  Created by Abhishek Rana on 30/01/19.
//  Copyright © 2019 Ankit_Saini. All rights reserved.
//

import UIKit

class ProductDetailVC: BaseViewController {
    private  var modalBar : BarcodeModal?
    @IBOutlet weak var lblStorageCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblStorageCondition.text = modalBar?.storageCondition ?? ""
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  
}
