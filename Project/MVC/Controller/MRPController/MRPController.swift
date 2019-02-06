//
//  MRPController.swift
//  DataKart
//
//  Created by Aseem 13 on 21/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class MRPController: BaseViewController {

    var modalBar : BarcodeModal?
    var datasource : TableViewDataSource?
    var array = [AnyObject]()
    var isBEE = false
    var isAgmark = false
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }

    func setupUI(){
        
        if isBEE{
            array = (modalBar?.beeArray)! as [AnyObject]
        }else if isAgmark{
            array = (modalBar?.agmarkArray)! as [AnyObject]
        }else{
            array = (modalBar?.mrpInfo)!
        }
        
        setTableData()
        
    }
    
    func setTableData() {
        
        datasource = TableViewDataSource(items: array, items2: nil, height: isBEE || isAgmark ? 50 : 150, tableView: tableView, cellIdentifier: isBEE || isAgmark ? "BEECell" :"MRPCell", configureCellBlock: { (cell, item, item2, indexpath) in
            
            let cell2 = cell as? MRPCell
            cell2?.configureCell(item: item, isBEE : self.isBEE, isAgmark : self.isAgmark)
            
            }, aRowSelectedListener: { (indexPath, item) in
        
        })
        tableView.dataSource = datasource
        tableView.delegate = datasource
        tableView.reloadData()
    }
    
}
