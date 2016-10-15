//
//  ViewController.swift
//  Back to Bach
//
//  Created by Hugo Morelli on 10/12/16.
//  Copyright © 2016 Hugo Morelli. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var scrubberSlider: UISlider!
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "OtraVez", ofType: "mp3")
    var timer = Timer()
    //MARK: Actions
    
    func updateScrubber(){

        scrubberSlider.value = Float(player.currentTime)
        
    }
   
    @IBAction func play(_ sender: AnyObject) {
        
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self , selector: #selector(ViewController.updateScrubber), userInfo: nil , repeats: true)
    }
    
    @IBAction func pause(_ sender: AnyObject) {
        
        player.pause()
        timer.invalidate()
    }
    @IBAction func stop(_ sender: AnyObject) {
        
        scrubberSlider.value = 0    
        timer.invalidate()
        player.pause()
        
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubberSlider.maximumValue = Float(player.duration)
            
        }catch{
            
        }
        

    }
    @IBAction func volume(_ sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func scrubbeMoved(_ sender: AnyObject) {
        
        player.currentTime = TimeInterval(scrubberSlider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubberSlider.maximumValue = Float(player.duration)

        }catch{
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

