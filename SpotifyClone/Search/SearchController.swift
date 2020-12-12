//
//  SearchController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class SearchController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    func setupView(){
        let searchView = SearchView(frame: self.view.bounds)
        self.view.addSubview(searchView)
        searchView.backgroundColor = .green
        
        
        let collectionViewController = GenreCollectionViewController()

        self.addChild(collectionViewController)
        
        searchView.collectionView = collectionViewController.view
        searchView.setupView()
        
    }
}
