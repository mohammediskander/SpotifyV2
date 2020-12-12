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
    
    let songBacgroundView = UIImageView()

    let songName = UILabel()
    let artistsName = UILabel()

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
        self.backgroundColor =  #colorLiteral(red: 0.2067485154, green: 0.2055261135, blue: 0.2076924443, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented.")
    }
    
    func setupMainStackView() {
        
        let mainStackView = UIStackView()
        mainStackView.axis  = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution  = .equalSpacing
//        mainStackView.backgroundColor = .red
        
        mainStackView.spacing   = 10
        
        setupHederStackView(inView: mainStackView)
        setupImageView(inView: mainStackView)
        setupMusicTitle(inView: mainStackView)
        setupMusicSlider(inView: mainStackView)
        setupPlayerControlls(inView: mainStackView)
        setupMusicList(inView: mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainStackView)
        
        mainStackView.setConstraints([
            .top(padding: 10, from: self.safeAreaLayoutGuide.topAnchor),
            .left(padding: 20, from: self.safeAreaLayoutGuide.leftAnchor),
            .right(padding: -20, from: self.safeAreaLayoutGuide.rightAnchor),
            .bottom(padding: -20, from: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupHederStackView(inView:UIStackView)  {

        let headerStackView = UIStackView()
        inView.addArrangedSubview(headerStackView)
        headerStackView.axis = .horizontal

        headerStackView.setConstraints([
            .right(padding: 0, from: inView.rightAnchor)
        ])
        
        // dismiss view button
        dismissButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dismissButton.tintColor = .white
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.addArrangedSubview(dismissButton)
        
        dismissButton.setConstraints([
            .height(40),
            .width(40),
        ])
        
        // ARTIST NAME
        artistName.textColor = .white
        artistName.text  = "ARTIST_NAME"
        artistName.textAlignment = .center
        artistName.setConstraints([
            .height(40)
        ])
        headerStackView.addArrangedSubview(artistName)
        

        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .white
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.addArrangedSubview(moreButton)
        
        moreButton.setConstraints([
            .height(40),
            .width(40),
        ])
      
        
    }
    
    private func setupImageView(inView: UIStackView){
        inView.addArrangedSubview(songBacgroundView)
        songBacgroundView.backgroundColor =  #colorLiteral(red: 0.3223227262, green: 0.3204120994, blue: 0.3237949014, alpha: 1)
        
        
        songBacgroundView.setConstraints([
            .height(500),
            .right(padding: 0, from: inView.rightAnchor)
        ])
        
    }
    
    private func setupMusicTitle(inView:UIStackView) {
        
        let musicStackView = UIStackView()
        musicStackView.axis = .vertical
        musicStackView.distribution = .fillProportionally
        inView.addArrangedSubview(musicStackView)
        
        // SONG NAME
        songName.textColor = .white
        songName.text  = "SONG_NAME"
        songName.textAlignment = .left
        songName.font = UIFont.boldSystemFont(ofSize: 25)
        songName.setConstraints([
            .height(30)
        ])
        musicStackView.addArrangedSubview(songName)
        
        
         // ARTIST NAME
        artistsName.textColor = .white
        artistsName.text  = "ARTIST_NAME(S)"
        artistsName.textAlignment = .left
        artistsName.font = UIFont.boldSystemFont(ofSize: 17)
        artistsName.setConstraints([
            .height(30)
        ])
        musicStackView.addArrangedSubview(artistsName)
        
    }
    
    private func setupMusicSlider(inView: UIStackView) {
        let silderStack = UIStackView()
        silderStack.axis = .vertical
        silderStack.spacing = 5
        inView.addArrangedSubview(silderStack)
        
        silderStack.setConstraints([
            .right(padding: 0, from: inView.rightAnchor)
        ])
        
        musicSlider.tintColor = .white
//        musicSlider.thumbRect(forBounds: CGRect(x: 0, y: 0, width: 20, height: 20), trackRect: CGRect(x: 0, y: 0, width: 10, height: 10), value: 0)
        silderStack.addArrangedSubview(musicSlider)
        
        let timerStackView = UIStackView()
        
        startTime.textColor = .white
        startTime.text  = "0:00"
        startTime.font = UIFont.boldSystemFont(ofSize: 11)
        timerStackView.addArrangedSubview(startTime)
        
        endTime.textColor = .white
        endTime.text  = "-5:09"
        endTime.font = UIFont.boldSystemFont(ofSize: 11)
        timerStackView.addArrangedSubview(endTime)
        
        silderStack.addArrangedSubview(timerStackView)
    }
    
    private func setupPlayerControlls(inView: UIStackView) {
        
        let playerStackView = UIStackView()
        playerStackView.alignment = .center
        playerStackView.distribution = .fillProportionally
        inView.addArrangedSubview(playerStackView)
        
        playerStackView.setConstraints([
            .right(padding: 0, from: inView.rightAnchor)
        ])
        
        // shuffle music button
        shuffleMusicButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        shuffleMusicButton.tintColor = .white
        
        playerStackView.addArrangedSubview(shuffleMusicButton)
        
        // backward music button
        backwardMusicButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        backwardMusicButton.tintColor = .white
        backwardMusicButton.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)

        playerStackView.addArrangedSubview(backwardMusicButton)
         
        // play music button
        playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playMusicButton.tintColor = .black
        playMusicButton.backgroundColor = .white
        playMusicButton.setPreferredSymbolConfiguration(.init(pointSize: 30), forImageIn: .normal)
        playerStackView.addArrangedSubview(playMusicButton)
        playMusicButton.setConstraints([
            .height(64),
            .width(64)
        ])
        playMusicButton.layer.cornerRadius = 32

        // forward music button
        forwardMusicButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        forwardMusicButton.tintColor = .white
        forwardMusicButton.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)

        playerStackView.addArrangedSubview(forwardMusicButton)
        
        // repeat music button
        repeatMusicButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        repeatMusicButton.tintColor = .white
        
        playerStackView.addArrangedSubview(repeatMusicButton)
    }
    
    func setupMusicList(inView:UIStackView)  {
      
        let footerStackView = UIStackView()
        footerStackView.distribution = .equalSpacing
        
        inView.addArrangedSubview(footerStackView)
        
        footerStackView.setConstraints([
            .right(padding: 0, from: inView.rightAnchor)
        ])
        
        deviceName.backgroundColor = .white

        deviceName.setConstraints([
            .width(20),
            .height(20)
        ])
        footerStackView.addArrangedSubview(deviceName)

        listMusicButton.backgroundColor = .white

        listMusicButton.setConstraints([
            .width(20),
            .height(20)
        ])
        footerStackView.addArrangedSubview(listMusicButton)
    }
}
