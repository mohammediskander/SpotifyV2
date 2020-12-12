//
//  PlayerView.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class PlayerView: UIView {
    
    let dismissButton = UIButton()
    let moreButton = UIButton()
    let artistName = UILabel()
    
    let songBackgroundView = UIImageView()

    let songName = UILabel()
    let artistNames = UILabel()
    let likeButon = UIButton()

    let musicSlider = UISlider()
    let startTime = UILabel()
    let endTime = UILabel()

    let shuffleMusicButton = UIButton()
    let backwardMusicButton  = UIButton()
    let playMusicButton = UIButton()
    let forwardMusicButton = UIButton()
    let repeatMusicButton = UIButton()

    let deviceName = UIButton()
    let listMusicButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  #colorLiteral(red: 0.1597638428, green: 0.1605103612, blue: 0.1623097956, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented.")
    }
    
    func setupSongInfo(songName: String , backgroundImage: UIImage ,  artistName: String , artistNames: String , isLike: Bool , endTime: TimeInterval) {
        
        self.songName.text = songName
        self.songBackgroundView.image = backgroundImage
        self.artistName.text = artistName
        self.artistNames.text = artistNames
        self.endTime.text = "-" + endTime.stringFromTimeInterval()
        self.musicSlider.maximumValue = Float(endTime)
        switch isLike {
        case true:
            likeButon.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        case false:
            likeButon.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
