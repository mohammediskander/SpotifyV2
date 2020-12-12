//
//  GenreView.swift
//  SpotifyClone
//
//  Created by Mohammed Alzuwayyid on 12/12/2020.
//

import UIKit

class GenreView: UIView{
    var collectionView: UICollectionView!
    var searchTextfield = customTextFieldWithIcon()

    func setupView(){
        self.addSubview(collectionView)
        
        setupSearchTextField()
        collectionView.setConstraints([
            .top(padding: 20, from: searchTextfield.bottomAnchor),
            .bottom(padding: 0, from: bottomAnchor),
            .horizontal(padding: 0)
        ])
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSearchTextField(){
        self.addSubview(searchTextfield)
        searchTextfield.textField.text = "Artist, songs, or podcasts"
        searchTextfield.backgroundColor = .white
        searchTextfield.textField.textColor = .black

        searchTextfield.imageView.image = UIImage(systemName: "magnifyingglass")
        searchTextfield.setConstraints([
            .top(padding: 0, from: self.safeAreaLayoutGuide.topAnchor),
            .height(43),
            .leading(padding: 15, from: self.safeAreaLayoutGuide.leadingAnchor),
            .trailing(padding: -15, from: self.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    
        
        
        searchTextfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}

