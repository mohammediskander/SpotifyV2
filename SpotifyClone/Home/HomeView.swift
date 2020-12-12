//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class HomeView: UIView {
    #warning("change to text class")
    var collectionView: UIView!
    
    
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.09410376102, green: 0.09412736446, blue: 0.09410066158, alpha: 1)
        self.addSubviews(collectionView)
                
        collectionView.setConstraints([
            .top(padding: 0, from: topAnchor),
            .horizontal(padding: 0),
            .bottom(padding: 0, from: bottomAnchor)
        ])
    
        
    }
}
