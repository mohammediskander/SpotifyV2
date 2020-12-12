//
//  LibraryViewController.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 12/12/2020.
//

import UIKit

class LibraryController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        let libraryView = LibraryView(frame: self.view.bounds)
        self.view.addSubview(libraryView)
        libraryView.backgroundColor = .red
        let libraryTableViewController = LibraryTableViewController()
        self.addChild(libraryTableViewController)
        libraryView.tableView = libraryTableViewController.view
        libraryView.setupView()
    }
    
}
