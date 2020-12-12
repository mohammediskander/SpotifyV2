//
//  AlbumDataSource.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

protocol AlbumDataSourceDelegate: AnyObject {
    
}

class AlbumDataSource: NSObject {
    
    static var shared = AlbumDataSource()
    weak var delegate: AlbumDataSource?
    
    
    
    var albums: [Album] = []
    
    func fetchAlbum(with ids: [String]) {
        // 
    }
    
}
