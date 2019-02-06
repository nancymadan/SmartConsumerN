//
//  ASplash.swift
//  Joint
//
//  Created by Mr. X on 04/06/18.
//  Copyright © 2018 Ankit_Saini. All rights reserved.
//

let kDefaultCenter = NotificationCenter.default

import UIKit
import AVFoundation

class ASplash: UIView {

    var playerAV: AVPlayer?
    var playerLayerAV: AVPlayerLayer?
    
    //MARK:-
    //MARK: View Cycle
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
       startVideo()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:-
    // MARK: Play Video
    // MARK:
    
    /**
     * @Author : Ankit Saini on 7/12/2017 v1.0
     *
     * Function name: startVideo
     *
     * @description:  This function will start the video on the splash screen
     *
     */
    
    func startVideo() {
        
        let url = Bundle.main.url(forResource: "video", withExtension: "mp4")
        if url == nil {
            return
        }
        
        if  playerAV == nil {
            playerAV = AVPlayer.init(url: url!)
        }
        
        playerAV?.isMuted = false
        if playerLayerAV == nil {
            playerLayerAV = AVPlayerLayer(player: playerAV)
            
        } else {
            playerLayerAV?.player = playerAV
        }
        
        playerLayerAV?.videoGravity = .resizeAspect //.resizeAspectFill
        playerLayerAV?.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        self.layer.addSublayer(playerLayerAV!)
        playerAV?.play()
        
        kDefaultCenter.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerAV?.currentItem, queue: .main) { (_) in
//            self.playerAV?.seek(to: CMTime.zero)
//            self.playerAV?.play()
            kDefaultCenter.post(name: Notifications.splashRemove.name, object: nil)
        }
    }
    
}
