//
//  HeaderVC.swift
//  DataKart
//
//  Created by Aseem 13 on 21/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderVC: PhotoBrowserController {

    @IBOutlet weak var collectionView: UICollectionView!
    var modalBar : BarcodeModal?
    var datasource : CollectionViewDataSource?
    var array = [AnyObject]()
    
    @IBOutlet weak var imagePlaceholder: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromModal(modal : BarcodeModal) {
        modalBar = modal
    }
    
    func setupUI(){
        
        array = (modalBar?.ImagesArray)! as [AnyObject]
        if array.count == 0 {
            imagePlaceholder.isHidden = false
            collectionView.isHidden = true
        }
        setTableData()
        
    }
    
    func setTableData() {
        
        datasource = CollectionViewDataSource(items: array, collectionView: collectionView, cellIdentifier: "ImagesCell", headerIdentifier: "", cellHeight: 300, cellWidth: self.view.frame.size.width, configureCellBlock: { (cell, item, item2, indexpath) in
            
            let cell2 = cell as? ImagesCell
            cell2?.configureCell(item: item as! String)
            
            }, aRowSelectedListener: { (indexPath, item) in
                
                self.didSelectMethodCalled(indexPath: indexPath, item: item as! String)
            }, scrollViewListener: { (UIScrollView) in
        })
        
        collectionView.dataSource = datasource
        collectionView.delegate = datasource
        collectionView.reloadData()
    }
    
    
    func didSelectMethodCalled(indexPath : NSIndexPath , item : String){
        
        var photos = [String]()
        
        for url in array {
            photos.append(url as! String)
        }
        
        getImagesArray(array: photos , photoIndex : UInt(indexPath.row))
        
        
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }

}

