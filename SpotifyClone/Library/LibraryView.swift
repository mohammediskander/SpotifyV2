//
//  LibraryView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 12/12/2020.
//

import UIKit
class LibraryView: UIView {
    var label: UILabel!
    var segmentedControl: UISegmentedControl!
    var tableView: UIView!
    
    func setupView() {
        segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentTintColor = .lightGray
        segmentedControl.insertSegment(withTitle: "Playlists", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Artists", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Album", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        label = UILabel()
        label.text = "Music"
        label.font = UIFont(name: AppFontName.bold, size: 30)
        label.textColor = .white

        
        
        backgroundColor = #colorLiteral(red: 0.09410376102, green: 0.09412736446, blue: 0.09410066158, alpha: 1)
        self.addSubviews(tableView,segmentedControl,label)
                
        tableView.setConstraints([
            .top(padding: 10, from: segmentedControl.bottomAnchor),
            .horizontal(padding: 0),
            .bottom(padding: 0, from: bottomAnchor)
        ])
        segmentedControl.setConstraints([
            .top(padding: 2, from: label.bottomAnchor),
            .horizontal(padding: 10),
        ])
        label.setConstraints([
            .top(padding: 5, from: safeAreaLayoutGuide.topAnchor),
            .horizontal(padding: 10),
            .height(50)
        ])
    
        
    }
}
