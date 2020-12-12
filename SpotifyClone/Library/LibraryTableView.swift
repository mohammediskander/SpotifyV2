//
//  LibraryTableView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 12/12/2020.
//

import UIKit

class LibraryTableView: UIView {
    
    var tableView: UITableView!
    
    func setupView() {

        self.addSubview(tableView)
        
        tableView.setConstraints([
            .top(padding: 0, from: nil),
            .horizontal(padding: 0),
            .bottom(padding: 0, from: bottomAnchor)
        ])
        tableView.backgroundColor = #colorLiteral(red: 0.09410376102, green: 0.09412736446, blue: 0.09410066158, alpha: 1)

    }
    
}
