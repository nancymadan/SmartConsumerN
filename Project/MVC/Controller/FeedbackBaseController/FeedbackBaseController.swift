//
//  FeedbackBaseController.swift
//  DataKart
//
//  Created by Aseem 13 on 14/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class FeedbackBaseController: UIViewController {
    var modal1 = BarcodeModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showFeedbackForm(controller: UIViewController){
        
        self.PushFeedbackController(controller: controller)
        
    }
    
    func PushFeedbackController(controller : UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let feedback = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as? FeedbackVC else {return}
        controller.navigationController?.pushViewController(feedback, animated: true)
        
    }
    
}
