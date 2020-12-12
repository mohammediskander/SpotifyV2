//
//  ArtistDataSource.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

protocol ArtistDataSourceDelegate: AnyObject {
    func dataLoaded()
}

class ArtistDataSource: NSObject {
    static var shared = ArtistDataSource()
    
    
}
