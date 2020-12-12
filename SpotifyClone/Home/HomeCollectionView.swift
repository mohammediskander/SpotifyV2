//
//  AlbumArtistView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 10/12/2020.
//

import UIKit

class HomeCollectionView: UIView {
    
    var collectionView: UICollectionView!
    
    func setupView() {

        self.addSubview(collectionView)
        
        collectionView.setConstraints([
            .top(padding: 0, from: nil),
            .horizontal(padding: 0),
            .bottom(padding: 0, from: bottomAnchor)
        ])
        collectionView.backgroundColor = #colorLiteral(red: 0.09410376102, green: 0.09412736446, blue: 0.09410066158, alpha: 1)

    }
    
}
