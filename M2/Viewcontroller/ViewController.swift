//
//  ViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 26/08/2022.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var singupbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupelements()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set up video in the background
        setUpVideo()
    }
    
    func setupelements(){
        Utilities.styleFilledButton(singupbutton)
        Utilities.styleHollowButton(loginbutton)
           
    }
    func setUpVideo() {
        
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "pexels-vlada-karpovich-8045191", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.6, y: 0, width: self.view.frame.size.width*4.1, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.7)
    }

}

