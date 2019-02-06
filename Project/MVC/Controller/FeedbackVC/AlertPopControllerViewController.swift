//
//  AlertPopControllerViewController.swift
//  JagrukGrahak
//
//  Created by Sierra 4 on 07/09/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import HCSStarRatingView

class AlertPopControllerViewController: UIViewController {
    var valueRating = CGFloat()
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var ratingPopView: HCSStarRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    
    func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    

}
