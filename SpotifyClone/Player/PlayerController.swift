//
//  PlayerController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class PlayerController: UIViewController {
    
    var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    func setupView() {
        playerView = PlayerView(frame: self.view.bounds)
        self.view.addSubview(playerView)
        playerView.setupMainStackView()
        
        playerView.playMusicButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
    }
    
    @objc
    func playSong() {
        print("play")
    }
}
