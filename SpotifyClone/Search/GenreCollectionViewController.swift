//
//  GenreCollectionViewController.swift
//  SpotifyClone
//
//  Created by Mohammed Alzuwayyid on 12/12/2020.
//

import UIKit

class GenreCollectionViewController: UIViewController{
    var genreView: GenreView!
    var collectionView: UICollectionView!
    var cellNumber = [2,2,6]
    var category = ["Your top genres","Popular brodcast","Browse all"]
    var genresArr = ["Hip Hop","Pop","Educationl","True Crime","Podcasts","Made for You", "Charts"]
    let arrColors = [UIColor.systemRed, UIColor.systemGreen, UIColor.systemPink, UIColor.systemBlue, UIColor.systemOrange]
    
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        
        // MARK: - Data Source and delegation
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GenreCard.self, forCellWithReuseIdentifier: "reuse")
        collectionView.register(Header.self, forSupplementaryViewOfKind: GenreCollectionViewController.categoryHeaderId, withReuseIdentifier: headerId)
        collectionView.allowsSelection = false

        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

        
        setupView()
    }
    
    func setupView(){
        genreView = GenreView(frame: view.bounds)
        genreView.collectionView = self.collectionView

        
        genreView.setupView()
        self.view = genreView
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func createLayout() -> UICollectionViewLayout {

        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.485), heightDimension: .absolute(105))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets.trailing = 1
           item.contentInsets.leading = 1
        
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none

            section.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 15, bottom: 0, trailing: 15)
            section.interGroupSpacing = 10
            
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: GenreCollectionViewController.categoryHeaderId, alignment: .topLeading)
            ]
            
            return section
        }

    }
    

    
}

extension GenreCollectionViewController: UICollectionViewDelegate{
    
    
}

extension GenreCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension GenreCollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNumber[section]
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath) as! GenreCard
        cell.setupView()
        var randomNumber = Int.random(in: 0...4)
        
        cell.label.text = genresArr[randomNumber]
        cell.backgroundColor = arrColors[randomNumber]
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.label.text = category.randomElement()
        header.label.font = UIFont(name: AppFontName.black, size: 20)
        
        return header
    }
    
    
}


class GenreCard: UICollectionViewCell{
    var label: UILabel! = {
        var label = UILabel()
        label.text = ""
        return label
    }()
    
    func setupView(){
        self.addSubview(label)
        label.setConstraints([
            .leading(padding: 10, from: self.leadingAnchor),
            .top(padding: 10, from: self.topAnchor)
        ])
    }
}

class Header: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Categories"
        
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
