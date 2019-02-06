//
//  ImagePickerController.swift
//  HutchDecor
//
//  Created by Aseem 13 on 12/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

class ImagePickerController: NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

     var appDelegate = AppDelegate()
     var Photo : FeedbackVC?
     let picker2 = UIImagePickerController()
     static let sharedInstance = ImagePickerController()
    
    override init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    
    func addPicture(controller : FeedbackVC) {
        
        Photo = controller
        
        let actionSheetTitle = "Complete Action Using"
        let destructiveTitle = "Cancel"
        let btn1 = "Gallery"
        let btn2 = "Camera"
        
        let alert = UIAlertController(title: actionSheetTitle, message: "", preferredStyle: .actionSheet)
        
        
        let Upload = UIAlertAction(title: btn1, style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            
            controller .present(picker, animated: true, completion: nil)
            alert.dismiss(animated: true, completion: nil)
            
            
        })
        let Camera = UIAlertAction(title: btn2, style: .default, handler: { (action:UIAlertAction!) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
            if !(UIImagePickerController.isSourceTypeAvailable(.camera)){
                
            }else{
               self.popCamera()
            }
            
            
        })
        let Cancel = UIAlertAction(title: destructiveTitle, style: .cancel, handler: { (action:UIAlertAction!) -> Void in
            alert.dismiss(animated: true, completion: nil)
            
        })
        alert.addAction(Upload)
        alert.addAction(Camera)
        alert.addAction(Cancel)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func popCamera(){
        picker2.delegate = self
        picker2.allowsEditing  = true
        picker2.sourceType = .camera
        appDelegate.window?.rootViewController?.present(picker2, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage  = info[UIImagePickerController.InfoKey.editedImage]
        sendImageBack(image: chosenImage as! UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func sendImageBack(image : UIImage) {
        
        
        Photo!.getImage(image: image)
       
        
    }
}

