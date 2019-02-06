//
//  CollectionViewDataSource.swift
//  Whatashadi
//
//  Created by Night Reaper on 29/10/15.
//  Copyright © 2015 Gagan. All rights reserved.
//


import UIKit

typealias ScrollViewScrolled = (UIScrollView) -> ()

class CollectionViewDataSource: NSObject  {
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var headerIdentifier : String?
    var collectionView  : UICollectionView?
    var cellHeight : CGFloat = 0.0
    var cellWidth : CGFloat = 0.0
    var scrollViewListener : ScrollViewScrolled?
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    
    init (items : Array<AnyObject>?  , collectionView : UICollectionView? , cellIdentifier : String? , headerIdentifier : String? , cellHeight : CGFloat , cellWidth : CGFloat  , configureCellBlock : @escaping ListCellConfigureBlock  , aRowSelectedListener : @escaping DidSelectedRow , scrollViewListener : @escaping ScrollViewScrolled)  {
        
        self.collectionView = collectionView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.headerIdentifier = headerIdentifier
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.configureCellBlock = configureCellBlock
        self.aRowSelectedListener = aRowSelectedListener
        self.scrollViewListener = scrollViewListener
        
    }
    
    override init() {
        super.init()
    }
    
}

extension CollectionViewDataSource : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier ,
                                                      for: indexPath) as UICollectionViewCell
        if let block = self.configureCellBlock , let item: AnyObject = self.items?[indexPath.row]{
            block(cell , item ,item, indexPath as AnyObject)
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let block = self.aRowSelectedListener, let item: AnyObject = self.items?[indexPath.row]{
            block(indexPath as NSIndexPath ,item)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            if let block = scrollViewListener {
                block(scrollView)
            }
        }

}


extension CollectionViewDataSource : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize.init(width: cellWidth, height: cellHeight)
    }
}

/*
extension CollectionViewDataSource : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.tableView?.collectionViewLayout as? UICollectionViewFlowLayout where scrollView.contentOffset.y < 0 else{return}
        let cellWithIncludingSpace = tableViewRowWidth + layout.minimumLineSpacing
        var offset = targetContentOffset.memory
        let index = round((scrollView.contentInset.left + offset.x)/cellWithIncludingSpace)
        offset = CGPointMake(index * cellWithIncludingSpace  - scrollView.contentInset.left - (2 * layout.minimumLineSpacing) , -scrollView.contentInset.top)
        targetContentOffset.memory = offset        
    }
}
 */
