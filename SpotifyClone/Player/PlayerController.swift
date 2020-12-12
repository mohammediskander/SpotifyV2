//
//  PlayerController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit
import AVFoundation
import MediaPlayer

struct SongSetting{
    var repeatState = Repeat.notRepeat
    var isShuffle = true
    var isPlaying = false
    var updateSlider = true
}

enum Repeat {
    case notRepeat
    case `repeat`
    case repeat1
}

class PlayerController: UIViewController , AVPlayerItemOutputPullDelegate{
    
    var playerView: PlayerView!
    var songSetting = SongSetting()
    var audioPlayer : AVPlayer!
    
    var timer: DispatchSourceTimer?
    
    var url : URL! {
        didSet{
            initMusicPlayer()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRemoteTransportControls()
        setupInterreuptionsNotifications()
        setupRouteChangeNotifications()
        
        self.setupView()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { (_) in
            switch self.songSetting.repeatState{
            case .notRepeat:
                break
            case .repeat:
                self.repeatAlbum()
            case .repeat1:
                self.repeat1()
            }

        }
    }
    
    func initMusicPlayer() {
        audioPlayer = AVPlayer(url: url)
        let duration = audioPlayer.currentItem?.asset.duration.seconds
        
        let image = UIImage(named: "testSongBackground")
        playerView.setupSongInfo(songName: "cardign", backgroundImage: image!, artistName: "folklore", artistNames: "Taylor Swift", isLike: false, endTime: duration!)
        
        setupNowPlaying("cardign", image: image)
    }
    
    func update() {
        if self.songSetting.updateSlider == false{
            return
        }
        
        self.playerView.musicSlider.value = Float(audioPlayer.currentTime().seconds)
        self.playerView.startTime.text = "\(audioPlayer.currentTime().seconds.stringFromTimeInterval())"
        self.playerView.endTime.text = "-\(TimeInterval((audioPlayer.currentItem?.asset.duration.seconds)! - audioPlayer.currentTime().seconds).stringFromTimeInterval())"
    }
    
    func startUpdating() {
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: .milliseconds(16), leeway: .milliseconds(5))
        timer?.setEventHandler(qos: .userInitiated, flags: [], handler: self.update)
        timer?.resume()
    }
    
    func stopUpdating() {
        timer?.cancel()
        timer = nil
        //        update()
    }
    
    func play() {
        audioPlayer.play()
        songSetting.isPlaying = true
        startUpdating()
    }
    
    func pause() {
        audioPlayer.pause()
        songSetting.isPlaying = false
        stopUpdating()
    }
    
    func repeatAlbum() {
        fatalError("😂😂😂😂😂😂😂")
    }
    
    func repeat1() {
        audioPlayer.seek(to: .zero)
        audioPlayer.play()
    }
    
    func setupView() {
        
        playerView = PlayerView(frame: self.view.bounds)
        self.view.addSubview(playerView)
        playerView.setupMainStackView()
        
        setupButtonAction()
        
        
        self.url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
        
        
    }
    
    func setupButtonAction() {
        playerView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        playerView.moreButton.addTarget(self, action: #selector(moreOptions), for: .touchUpInside)
        playerView.likeButon.addTarget(self, action: #selector(likeSong), for: .touchUpInside)
        playerView.shuffleMusicButton.addTarget(self, action: #selector(shuffleSongs), for: .touchUpInside)
        playerView.backwardMusicButton.addTarget(self, action: #selector(backwardSong), for: .touchUpInside)
        playerView.playMusicButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        playerView.forwardMusicButton.addTarget(self, action: #selector(forwardSong), for: .touchUpInside)
        playerView.repeatMusicButton.addTarget(self, action: #selector(repeatSong), for: .touchUpInside)
        
        playerView.musicSlider.addTarget(self, action: #selector(playbackSliderValueWillChange(_:)), for: .touchDown)
        playerView.musicSlider.addTarget(self, action: #selector(playbackSliderValueDidEndChanged(_:)), for: .touchUpInside)
        playerView.musicSlider.addTarget(self, action: #selector(playbackSliderValueChanged), for: .valueChanged)

        
        
    }
    @objc
    func dismissView() {
        print("dismiss")
    }
    
    @objc
    func moreOptions() {
        print("more options")
    }
    
    @objc
    func likeSong(sender: UIButton) {
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        sender.tintColor = .green
    }
    
    @objc
    func shuffleSongs(sender: UIButton) {
        
        switch songSetting.isShuffle {
        case true:
            songSetting.isShuffle = false
            sender.tintColor = .green
        case false:
            songSetting.isShuffle = true
            sender.tintColor = .white
        }
    }
    
    @objc
    func backwardSong() {
        print("backward")
    }
    
    @objc
    func playSong(sender: UIButton) {
        switch songSetting.isPlaying {
        case true:
            pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        case false:
            play()
            setupInterreuptionsNotifications()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
    }
    
    @objc
    func forwardSong() {
        print("forward")
    }
    
    @objc
    func repeatSong(sender: UIButton) {
        print(songSetting.repeatState)
        
        switch songSetting.repeatState {
        case .notRepeat:
            songSetting.repeatState = .repeat
            sender.tintColor = .green
            sender.setImage(UIImage(systemName: "repeat"), for: .normal)
            
        case .repeat:
            songSetting.repeatState = .repeat1
            sender.tintColor = .green
            sender.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            
        case .repeat1:
            songSetting.repeatState = .notRepeat
            sender.tintColor = .white
            sender.setImage(UIImage(systemName: "repeat"), for: .normal)
        }
    }
    
    @objc
    func playbackSliderValueWillChange(_ sender:UISlider) {
        songSetting.updateSlider = false
    }
    
    @objc
    func playbackSliderValueDidEndChanged(_ sender:UISlider) {
        let seconds = Int64(sender.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)

        songSetting.updateSlider = true
        audioPlayer.seek(to: targetTime)
       
        if songSetting.isPlaying != false{
            play()
        }
    }
    
    @objc
    func playbackSliderValueChanged(sender: UISlider) {
        self.playerView.startTime.text = "\(TimeInterval(sender.value).stringFromTimeInterval())"
        self.playerView.endTime.text = "-\(TimeInterval((audioPlayer.currentItem?.asset.duration.seconds)! - Double(sender.value)).stringFromTimeInterval())"
    }
    
    func isPlaying() -> Bool {
        return songSetting.isPlaying
    }
    
    func setupNowPlaying(_ title: String, image: UIImage?) {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title

        if let image = image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.currentItem!.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func setupRemoteTransportControls() {
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // reset default commands
        commandCenter.playCommand.removeTarget(nil)
        commandCenter.pauseCommand.removeTarget(nil)
        commandCenter.nextTrackCommand.removeTarget(nil)
        commandCenter.previousTrackCommand.removeTarget(nil)
        commandCenter.changePlaybackPositionCommand.removeTarget(nil)
        
        
        // handle CC play button clicked
        commandCenter.playCommand.addTarget {
            [unowned self] event in
            
            if !self.isPlaying() {
                play()
                return .success
            } else {
                return .commandFailed
            }
        }
        
        // handle CC pause button clicked
        commandCenter.pauseCommand.addTarget {
            [unowned self] event in
            
            if self.isPlaying() {
                pause()
                
                return .success
            } else {
                return .commandFailed
            }
        }
        
        // handle CC next track button clicked
//        commandCenter.nextTrackCommand.addTarget {
//            [unowned self] event in
//            self.audioPlayer.
//            self.audioPlayer.next()
//            return .success
//        }
        
        // handle CC previous track button clicked
//        commandCenter.previousTrackCommand.addTarget {
//            [unowned self] event in
//
//            self.prev()
//            return .success
//        }
        
        // handle CC playback position changed
        commandCenter.changePlaybackPositionCommand.addTarget {
            [unowned self] event in
            
            let e = event as? MPChangePlaybackPositionCommandEvent
//            self.audioPlayer.cu = e!.positionTime
//            self.audioPlayer.seek(to: e!.positionTime)
            self.audioPlayer.seek(to: CMTime(seconds: e!.positionTime, preferredTimescale: 1))
            return .success
        }
        
    }
    
    // MARK: Handle Interruptions
        /*
         When you are playing in background mode, if a phone call come
         then the sound will be muted but when hang off the phone call
         then the sound should automatically continue playing.
        */
        func setupInterreuptionsNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        }
        
        @objc func handleInterruption(notification: Notification) {
            guard let userInfo = notification.userInfo,
                let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
                let type = AVAudioSession.InterruptionType(rawValue: typeValue)
            else {
                return
            }
            
            
            if type == .began {
                print("Interruption began")
                // Interruption began, take appropriate actions
            }
            else if type == .ended {
                if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                    let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)

                    if options.contains(.shouldResume) {
                        // Interruption Ended - playback should resume
                        print("Interruption Ended - playback should resume")
                       play()
                    } else {
                        // Interruption Ended - playback should NOT resume
                        print("Interruption Ended - playback should NOT resume")
                        pause()
                    }
                }
            }
        }
    
    // MARK: Handle Route Changes
        /*
        when you plug a headphone into the phone then the sound will
         emit on the headphone. But when you unplug the headphone then
         the sound automatically continue playing on built-in speaker.
         Maybe this is the behavior that you don’t expect. B/c when you
         plug the headphone into you want the sound is private to you,
         and when you unplug it you don’t want it emit out to other people.
         We will handle it by receiving events when the route change
        */
        func setupRouteChangeNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
        }
        
        @objc func handleRouteChange(notification: Notification) {
            print("handleRouteChange")
            guard let userInfo = notification.userInfo,
                let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
                let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
                    return
            }

            switch reason {
                case .newDeviceAvailable:
                    let session = AVAudioSession.sharedInstance()
                    for output in session.currentRoute.outputs where
                        (output.portType == AVAudioSession.Port.headphones || output.portType == AVAudioSession.Port.bluetoothA2DP) {
                        print("headphones connected, \(Thread.current == Thread.main)")
//                        DispatchQueue.main.sync {
                        if self.isPlaying() {
                            print("should play?")
                        }
                            
//                        }
                        break
                    }
                case .oldDeviceUnavailable:
                    if let previousRoute =
                        userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                        for output in previousRoute.outputs where
                            (output.portType == AVAudioSession.Port.headphones || output.portType == AVAudioSession.Port.bluetoothA2DP) {
                            print("headphones disconnected, \(Thread.current == Thread.main)")
//                            DispatchQueue.main.sync {
//                                pause()
//                            }
                            print("should pause?")
                            break
                        }
                    }
                default: ()
            }
        }
}
