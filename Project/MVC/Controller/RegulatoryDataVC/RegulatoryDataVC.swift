//
//  RegulatoryDataVC.swift
//  JagrukGrahak
//
//  Created by Aseem 13 on 25/05/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit

class RegulatoryDataVC: BaseViewController {

    @IBOutlet weak var lblLicNo: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblSelfLife: UILabel!
    
    @IBOutlet var lblProductOnRecall: UILabel!
    @IBOutlet var lblBatchNum: UILabel!
    var modalBar : BarcodeModal?
    
    
    override func viewDidLoad() {
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    func setupUI(){
        
       
        lblLicNo?.text = modalBar?.licNo
        lblFoodType?.text = modalBar?.foodType
        lblSelfLife?.text = modalBar?.selfLyf
        
        if let recallInfo = modalBar?.recall_info{
            
            if let isRecallInfoEmpty = modalBar?.recall_info?.isEmpty{
                if !(isRecallInfoEmpty){
                    lblProductOnRecall.isHidden = false
                        if let batchNumber = recallInfo["batch_no"]?.stringValue{
                       lblBatchNum.text = "Following batch or batches of this Product is Under Recall,Please Check The Product Label before Use \(batchNumber)"
                    }
                }
                
            }
        }

    }
}
