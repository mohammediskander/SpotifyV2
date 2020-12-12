//
//  AlbumArtistCollectionView.swift
//  SpotifyClone
//
//  Created by Abdullah Alhomaidhi on 10/12/2020.
//

import UIKit

class HomeCollectionViewController: UIViewController {
    
    // MARK: - Vars
    var homeCollectionView: HomeCollectionView!
    var collectionView: UICollectionView!
    private var cellIdentfier = "cell"
    private var albumCellIdentfier = "albumCellIdentfier"
    private var topCellIdentfier = "topCellIdentfier"
    private var artistCellIdentfier = "artistCellIdentfier"


    private var headerIdentfier = "header"
    private static var headerKind = "headerKind"
    
    private var headers = ["Most Played","New","Top","Best"]
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: topCellIdentfier)
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellIdentfier)
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: artistCellIdentfier)


        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeCollectionViewController.headerKind, withReuseIdentifier: headerIdentfier)

        
        collectionView.delegate = self
        collectionView.dataSource = self

        
        setupView()
    }
    
    // MARK: - Setup
    func setupView() {
        homeCollectionView = HomeCollectionView(frame: self.view.bounds)
        homeCollectionView.collectionView = self.collectionView
        
        homeCollectionView.setupView()
        self.view = homeCollectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            
            if section == 0 {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = 5
                item.contentInsets.leading = 2.5
                item.contentInsets.trailing = 2.5

                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 10
                section.contentInsets.trailing = 10
                
                

                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeCollectionViewController.headerKind, alignment: .topLeading)
                ]
                
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .estimated(145))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 15, bottom: 0, trailing: 15)
                section.interGroupSpacing = 10
                section.contentInsets.bottom = 5
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeCollectionViewController.headerKind, alignment: .topLeading)
                ]
                
                return section
            }
            
            
        }
        
    }

    
}

// MARK: - Collection View Delegete
extension HomeCollectionViewController: UICollectionViewDelegate {
  
}

// MARK: - Collection View Data Source
extension HomeCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellIdentfier, for: indexPath) as! TopCell
            cell.image.image = #imageLiteral(resourceName: "Album")
            cell.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1529411765, blue: 0.1843137255, alpha: 1)
            cell.label.text = "Liked Songs"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: artistCellIdentfier, for: indexPath) as! ArtistCell
            cell.image.image = #imageLiteral(resourceName: "Album")
            cell.label.text = "Liked Songs"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentfier, for: indexPath) as! Header
        if indexPath.section == 0 {
            header.label.text = "Good Evening, Abdullah"
        } else {
            header.label.text = headers.randomElement()
        }
        return header
    }
    
    
}


// MARK: - Collection View Header

class Header: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = ""
        label.font = UIFont(name: AppFontName.bold, size: 20)
        label.textColor = .white


        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumCell: UICollectionViewCell {
    let image = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        addSubviews(image,label)
        label.setConstraints([
            .top(padding: 5, from: image.bottomAnchor),
            .horizontal(padding: 2)
        ])
        image.setConstraints([
            .top(padding: 0, from: topAnchor),
            .horizontal(padding: 0),
            .height(145 - (label.frame.height + 10)),
            .width(145 - (label.frame.height + 10)),
        ])
        label.font = UIFont(name: AppFontName.bold, size: 12)
        label.textColor = .white
    }
}

class ArtistCell: UICollectionViewCell {
    let image = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        addSubviews(image,label)
        label.setConstraints([
            .top(padding: 5, from: image.bottomAnchor),
            .horizontal(padding: 2)
        ])
        image.setConstraints([
            .top(padding: 0, from: topAnchor),
            .horizontal(padding: 0),
            .height(145 - (label.frame.height + 10)),
            .width(145 - (label.frame.height + 10)),
        ])
        label.font = UIFont(name: AppFontName.bold, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        image.layer.cornerRadius = (145 - (label.frame.height + 10))/2
        image.layer.masksToBounds = true
    }
}

class TopCell: UICollectionViewCell {
    let image = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        addSubviews(label,image)
        label.setConstraints([
            .leading(padding: 10, from: image.trailingAnchor),
            .vertical(padding: 0),
            .trailing(padding: 0, from: trailingAnchor)
        ])
        image.setConstraints([
            .vertical(padding: 0),
            .width(60),
            .leading(padding: 0, from: leadingAnchor)
        ])
        label.font = UIFont(name: AppFontName.bold, size: 12)
        label.textColor = .white
    }
}
