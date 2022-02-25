//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 이택성 on 2022/01/25.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    var movieResult: MovieResult?
    var player: AVPlayer?

    @IBOutlet weak var movieContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
    
    }
    
    // 디바이스의 크기나 위치값을 가져옴.
    override func viewDidAppear(_ animated: Bool) {
        
        if let hasURL = movieResult?.previewUrl{
            makePlayerAndPlay(urlString: hasURL)
        }
    }
    
    func makePlayerAndPlay(urlString: String) {
        
        if let hasUrl = URL(string: urlString){
            self.player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player) // 크기를 가지는 개념
            
            movieContainer.layer.addSublayer(playerLayer)
            
            playerLayer.frame = movieContainer.bounds   // 프레임 크기
            
            self.player?.play()
        }
        
    }
    
    @IBAction func play(_ sender: Any) {
        self.player?.play()
    }
    
    @IBAction func stop(_ sender: Any) {
        self.player?.pause()
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
