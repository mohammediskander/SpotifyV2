//
//  TimeInterval.swift
//  SpotifyClone
//
//  Created by Ali Al suhaimi on 27/04/1442 AH.
//

import UIKit

extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if hours > 0{
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
