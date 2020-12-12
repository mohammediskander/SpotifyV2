//
//  HomeController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class HomeController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        let homeView = HomeView(frame: self.view.bounds)
        self.view.addSubview(homeView)
        homeView.backgroundColor = .red
        let firstCollectionViewController = AlbumArtistCollectionViewController()
        self.addChild(firstCollectionViewController)
        homeView.firstCollectionView = firstCollectionViewController.view
        homeView.setupView()
    }
    
}
