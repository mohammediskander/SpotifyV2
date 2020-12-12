//
//  AlbumArtistCollectionView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 10/12/2020.
//

import UIKit

class AlbumArtistCollectionViewController: UIViewController {
    
    var albumArtistView: AlbumArtistView!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
//        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 150, height: 150),collectionViewLayout: UICollectionViewLayout())
//        collectionView = UICollectionView(frame: view.frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumArtistCard.self, forCellWithReuseIdentifier: "reuse")
        collectionView.allowsSelection = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

//        TaskService.shared.delegate = self
        
        let isoDate = "2021/01/17"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from:isoDate)!
        
//        TaskService.shared.create(task: Task(title: "Tuwaiq Bootcamp end", desc: nil, dueDate: date))
//        TaskService.shared.create(task: Task(title: "Clear room", desc: nil, dueDate: Date()))
//        TaskService.shared.create(task: Task(title: "Clear room", desc: nil, dueDate: Date()))
//        TaskService.shared.create(task: Task(title: "Clear room", desc: nil, dueDate: Date()))
//        TaskService.shared.create(task: Task(title: "Clear room", desc: nil, dueDate: Date()))
//        TaskService.shared.create(task: Task(title: "Clear room", desc: nil, dueDate: Date()))
        
        setupView()
    }
    
    func setupView() {
        albumArtistView = AlbumArtistView(frame: self.view.bounds)
        albumArtistView.collectionView = self.collectionView
        
        albumArtistView.setupView()
        self.view = albumArtistView
        view.backgroundColor = .blue
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 15, bottom: 0, trailing: 15)
            section.interGroupSpacing = 10
            
            return section
        }
        
    }
    
}

extension AlbumArtistCollectionViewController: UICollectionViewDelegate {
    
}

extension AlbumArtistCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath) as! AlbumArtistCard
        cell.setupView()
        cell.label.text = "Hello"
        cell.backgroundColor = .red
        return cell
    }
    
    
}

class AlbumArtistCard: UICollectionViewCell {
    
    var label: UILabel! = {
        var label = UILabel()
        label.text = ""
        return label
    }()
    
    
    func setupView() {
//        super.layoutSubviews()
        
        self.addSubview(label)
        
        label.setConstraints([
            .center
        ])
    }
}

