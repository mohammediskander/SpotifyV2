//
//  LibraryTableViewController.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 12/12/2020.
//

import UIKit
class LibraryTableViewController: UIViewController {
    
    // MARK: - Vars
    var libraryTableView: LibraryTableView!
    var tableView: UITableView!
    private var cellIdentfier = "cell"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: cellIdentfier)
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        
        setupView()
    }
    

        
        func setupView() {
            libraryTableView = LibraryTableView(frame: self.view.bounds)
            libraryTableView.tableView = self.tableView
            
            libraryTableView.setupView()
            self.view = libraryTableView
        }
    
}

// MARK: - TableView Data Source

extension LibraryTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier, for: indexPath) as! CustomTableCell
        cell.customImageView.image = #imageLiteral(resourceName: "Album")
        cell.label.text = "Liked Songs"
        cell.subLabel.text = "by Spotify"
        cell.backgroundColor = #colorLiteral(red: 0.09410376102, green: 0.09412736446, blue: 0.09410066158, alpha: 1)

        return cell
    }
    
    
}


// MARK: - TableView Delegate

extension LibraryTableViewController: UITableViewDelegate {
    
}


class CustomTableCell: UITableViewCell {
    let customImageView = UIImageView()
    let label = UILabel()
    let subLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        addSubviews(label,customImageView,subLabel)
        label.textAlignment = .left
        label.contentMode = .bottom
        
        subLabel.textAlignment = .left
        subLabel.contentMode = .top

        label.setConstraints([
            .top(padding: 10, from: topAnchor),
            .trailing(padding: 10, from: trailingAnchor),
            .leading(padding: 10, from: customImageView.trailingAnchor),
        ])
        subLabel.setConstraints([
            .leading(padding: 0, from: label.leadingAnchor),
            .trailing(padding: 0, from: label.trailingAnchor),
            .bottom(padding: -15, from: bottomAnchor),
            .top(padding: 5, from: label.bottomAnchor),
        ])
        customImageView.setConstraints([
            .yAxis(padding: 0, from: contentView.centerYAnchor),
            .width(60),
            .height(60),
            .leading(padding: 10, from: safeAreaLayoutGuide.leadingAnchor)
        ])
        label.font = UIFont(name: AppFontName.bold, size: 12)
        label.textColor = .white
        subLabel.font = UIFont(name: AppFontName.bold, size: 9)
        subLabel.textColor = .gray
    }
}
