//
//  SearchController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class SearchView: UIView{
    var headerTitle: UITextField!
    var collectionView: UIView!
    
    func setupView(){
        self.backgroundColor = .systemBackground
        headerTitle = UITextField()
        
        headerTitle.text = "Search"
        headerTitle.font = UIFont(name: AppFontName.bold, size: 40)
        
        addSubviews(headerTitle, collectionView)
        
        headerTitle.setConstraints([
            .top(padding: 0, from: nil),
            .horizontal(padding: 10)
        ])
        
        collectionView.setConstraints([
            .top(padding: 5, from: headerTitle.bottomAnchor),
            .bottom(padding: 0, from: bottomAnchor),
            .horizontal(padding: 0)
        ])
    }
    
}
