//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class HomeView: UIView {
    #warning("change to text class")
    var headerTitle: UITextField!
    var firstCollectionView: UIView!
    
    
    
    func setupView() {
        self.backgroundColor = .systemBackground
        headerTitle = UITextField()
        headerTitle.text = "Good Evening, Abdullah"
        headerTitle.font = UIFont(name: AppFontName.bold, size: 20)
//        self.headerTitle = UITextField("Hello, Mohammed", size: 20, font: AppFontName.bold)
        self.addSubviews(headerTitle,firstCollectionView)
        
        headerTitle.setConstraints([
            .top(padding: 0, from: nil),
            .horizontal(padding: 15)
        ])
        
        firstCollectionView.setConstraints([
            .top(padding: 5, from: headerTitle.bottomAnchor),
            .horizontal(padding: 0),
            .height(150)
        ])
    
        
    }
}
