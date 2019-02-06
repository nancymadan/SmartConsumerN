//
//  ImagesCell.swift
//  DataKart
//
//  Created by Aseem 13 on 12/10/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SDWebImage
import YouTubePlayer

class ImagesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {

    }
    
    func configureCell(item : String) {
        videoPlayer.isHidden = true
        
        if item.contains("https://youtu") {
            print("Youtube URL")
            print(item)
            
            videoPlayer.isHidden = false
            imageView.isHidden = true
            
            // Load video from YouTube URL
            let myVideoURL = URL(string: item)
            videoPlayer.loadVideoURL(myVideoURL!)
            
            
        } else{
            imageView.isHidden = false
            imageView.sd_setImage(with: URL(string: item), placeholderImage: UIImage(named: "splash"))
        }
    }

    
}
