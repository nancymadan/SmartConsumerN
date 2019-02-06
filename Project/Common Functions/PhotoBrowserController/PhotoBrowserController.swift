//
//  BaseViewController.swift
//  PhotoBrowserApp
//
//  Created by Aseem 13 on 12/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class PhotoBrowserController: UIViewController, MWPhotoBrowserDelegate {
    
    


    var photos = [MWPhoto]()

    let displayActionButton : Bool = true
    let displaySelectionButtons : Bool = false
    let displayNavArrows : Bool = false
    let enableGrid : Bool = true
    let startOnGrid : Bool = true
    let autoPlayOnAppear : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func getImagesArray (array : [String], photoIndex : UInt){
        
        var photo = [MWPhoto]()
        for item in array {
            if item.contains("https://youtu") {
                print("Youtube URL")
            } else{
                let pic = MWPhoto.init(url: URL(string: item))
                photo.append(pic!)
            }
            
        }
        if array[Int(photoIndex)].contains("https://youtu") {
            print("Youtube URL")
            return
        }
        
        photos = photo
        pushMWController(gridNeeded: false , photoIndex: photoIndex)
        
    }
   

    func pushMWController(gridNeeded : Bool, photoIndex : UInt)  {
        
        let browser = MWPhotoBrowser(delegate: self)
        browser?.displayActionButton = displayActionButton
        browser?.displayNavArrows = displayNavArrows
        browser?.displaySelectionButtons = displaySelectionButtons
        browser?.alwaysShowControls = displaySelectionButtons
        browser?.zoomPhotosToFill = true
        browser?.enableGrid = gridNeeded
        browser?.startOnGrid = gridNeeded
        browser?.enableSwipeToDismiss = false
        browser?.autoPlayOnAppear = autoPlayOnAppear
        browser?.setCurrentPhotoIndex(photoIndex)
        self.navigationController?.pushViewController(browser!, animated: true)
    }
    
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(photos.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol!{
        
        let ind = Int(index)
        if ind < photos.count {
            return photos[ind]
        }
        return nil
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, thumbPhotoAt index: UInt) -> MWPhotoProtocol!{
        let ind = Int(index)
        if ind < photos.count {
            return photos[ind]
        }
        return nil
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, didDisplayPhotoAt index: UInt){
        print("Did start viewing photo at index\(index)")
    }
    

    
}
