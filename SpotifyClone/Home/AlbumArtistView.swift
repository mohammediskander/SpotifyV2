//
//  AlbumArtistView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 10/12/2020.
//

import UIKit

class AlbumArtistView: UIView {
    
    var collectionView: UICollectionView!
//    var title: Text!
    
    func setupView() {
//        self.title = Text("Your Tasks", size: 20, font: AppFontName.bold)
//        self.addSubview(title)
        
//        title.setConstraints([
//            .horizontal(padding: 15),
//            .top(padding: 0, from: nil)
//        ])
        
        self.addSubview(collectionView)
        
        collectionView.setConstraints([
            .top(padding: 0, from: nil),
            .height(150),
            .horizontal(padding: 0)
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .yellow
        
    }
    
}
