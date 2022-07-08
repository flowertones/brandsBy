//
//  BrandListController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class BrandListController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
        var brandContent: BrandContent!

    private var sections = MockData.pageData
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()

        collectionView.register(UINib(nibName: String(describing: CategoriesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoriesCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))

        collectionView.register(
            BrandHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: BrandHeaderView.self)
        )
        configureNavbar()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        sections = MockData.pageData
        collectionView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .categories:
                //item
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                // group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(130), heightDimension: .absolute(40)), subitems: [item])
                //section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
                
            case .content:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute( self.view.frame.width / 2 - 10), heightDimension: .fractionalHeight(1)))
                // group
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .absolute(300)), subitem: item, count: 2)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(300)), subitems: [item])
                group.interItemSpacing = .fixed(20)
                //section
                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
    }
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil),
        ]
        navigationController?.navigationBar.tintColor = .label
    }
}


extension BrandListController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
        case .categories(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.setup(item[indexPath.row])
            return cell
        case .content(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
            cell.setup(items[indexPath.item])
            return cell
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BrandHeaderView", for: indexPath) as! BrandHeaderView
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let contentVC = ContentController.loadFromNib()
//        navigationController?.pushViewController(contentVC, animated: true)
//            print("gooooodddd")
    }
}

