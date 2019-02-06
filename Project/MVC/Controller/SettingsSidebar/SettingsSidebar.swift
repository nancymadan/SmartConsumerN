//
//  SettingsSidebar.swift
//  DataKart
//
//  Created by Aseem 13 on 20/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class SettingsSidebar: UIViewController {
    
    var datasource : TableViewDataSource?
    var array = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        array = ["About the App","Contact Details","Disclamer","Share App","Video"]
        setTableData()
    }
    
    func setTableData() {
        datasource = TableViewDataSource(items: array as Array<AnyObject>, items2: nil, height: 49.0, tableView: tableView, cellIdentifier: "SettingsCell", configureCellBlock: { (cell, item, item2, indexpath) in
            
            let cell = cell as? SettingsCell
            cell?.configureCell(title: item as? String)
            
            }, aRowSelectedListener: { (indexPath, item) in
                self.delegateMethodCalled(indexPath: indexPath)
                
        })
        tableView.dataSource = datasource
        tableView.delegate = datasource
        tableView.reloadData()
    }
    
    func delegateMethodCalled (indexPath : NSIndexPath){
        
        switch indexPath.row {
        case 0:
            self.pushViewController(tag: 0)
        case 1:
            self.pushViewController(tag: 1)
        case 2:
            self.pushViewController(tag: 2)
        case 3:
           shareApp()
        case 4:
            appDelegate.createSplash()
        default:
            break
        }
    }
    
    func shareApp(){
        
        let objectsToShare = ["Access complete product information before buying. Download Smart Consumer app for android: https://goo.gl/j2XAMt or iOS: https://goo.gl/u6XEF3."]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = sender as UIView
        let navigationController = self.findHamburguerViewController()?.contentViewController as? DLHamburguerNavigationController
        navigationController?.present(activityVC, animated: true, completion: nil)
        
    }
    
    func pushViewController(tag : Int){
        
        let webView = storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as? WebViewVC
        webView?.strLbl = sideBarText(value: tag)
       let navigationController = self.findHamburguerViewController()?.contentViewController as? DLHamburguerNavigationController
        
        navigationController!.pushViewController(webView!, animated: true)
        self.findHamburguerViewController()?.hideMenuViewControllerWithCompletion(nil)
    }
    
    @IBAction func btnCross(_ sender: AnyObject) {
        self.findHamburguerViewController()?.hideMenuViewControllerWithCompletion(nil)
        
    }
    
    func sideBarText(value : Int) -> String {
        switch value {
        case 0:
            return "Department of Consumer Affairs, Govt. of India, via this app enables consumers to connect digitally with brands to speed redressal of complaints.\n\nIn addition to providing consumer care details for lodging grievances and complaints, the app also provides product labelling information, per the Legal Metrology (Packaged Commodities) Rules 2011.\n\nBy simply scanning the product barcode or by entering a product’s barcode number (GTIN), consumers get access to the following product information:\n\n·         Product/Commodity Name\n\n·         Name & Address of Manufacturer/Packer/Importer\n\n·         Month & Year of Manufacture/Pack/Import\n\n·         MRP\n\n·         Net Content\n\n Smart Consumer mobile app has been developed in association with GS1 India, a standards body set up by Ministry of Commerce & Industry, Govt. of India, and BIS, ASSOCHAM, APEDA, FIEO, IIP, IMC, Spices Board, FICCI & CII.\n\n GS1 develops and manages the standards for GS1 barcodes globally."
        case 1:
            return "Director (Legal Metrology)\nDepartment of Consumer Affairs\nMinistry of Consumer Affairs, Food & Public Distribution\n\nPhone:   (011) 23389489\nE-mail:   dirwm-ca@nic.in\ndirwmca@fca.nic.in\n\nWebsite: www.consumeraffairs.nic.in\n\nNational consumer helpline number: 1800-11-4000"
        case 2 :
            return "Product information and product images displayed in the ‘Smart Consumer’ mobile app has been provided by the product's manufacturer/supplier through GS1 India's DataKart, and only they(manufacturer/supplier) are responsible for the information's completeness and accuracy.\nDepartment of Consumer Affairs and GS1 India are not responsible for completeness and accuracy of product data and images displayed through this app."
        default:
            return ""
        }
    }
    
}
