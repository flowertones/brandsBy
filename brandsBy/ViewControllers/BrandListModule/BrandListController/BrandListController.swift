//
//  BrandListController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class BrandListController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!

    var brandArray = [BrandContent]()


    private var sections = Sections.allCases
    private var category = Category.allCases
    private var filterText = ["СОРТИРОВАТЬ", "ФИЛЬТРЫ"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.contentInsetAdjustmentBehavior = .never
        
        NetworkManager.getBrand { brand in
            self.brandArray = brand
            print(self.brandArray.count)
            var allCategories = [String]()
            brand.forEach({ $0.categories.forEach({ allCategories.append($0)})})
            print(Set(allCategories.map({$0})))
            let mySet = Set<String>()
            let myList = Array(mySet.union(allCategories.map({$0}))).map({ ListItem(title: $0, image: "")})
            global = ListSection.categories(myList)
            self.collectionView.reloadData()
        } failureBlock: {
            print("Error")
        }
        
        
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
//        sections = MockData.pageData
        collectionView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .filters:
                //item
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute( self.view.frame.width / 2), heightDimension: .fractionalHeight(1)))
                // group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(60)), subitems: [item])
                //section
                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
                
            case .category:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(130), heightDimension: .absolute(40)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                return section
                
            case .countBrand:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(20)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                return section
                
            case .content:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute( self.view.frame.width / 2 - 10), heightDimension: .fractionalHeight(1)))
                // group
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .absolute(300)), subitem: item, count: 2)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(270)), subitems: [item])
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
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
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

        switch sections[section] {
            
        case .filters:
            return filterText.count
        case .category:
            return category.count
        case .countBrand:
            return 1
        case .content:
            return brandArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
        case .filters:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
                cell.categoryLabel.text = filterText[indexPath.row]
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.setupCategory(category: category[indexPath.row])
            return cell
            
        case .countBrand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.categoryLabel.text = "\(brandArray.count)"
//            var countBrandLabel = ""
//            if brandArray.count == 1, 21 {
//                countBrandLabel = "бренд"
//            } else if brandArray.count == 2, 3, 4 {
//                countBrandLabel = "бренда"
//            } else if 4 < brandArray.count < 21 {
//                countBrandLabel = "брендов"
//            }
            return cell
            
        case .content:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
            cell.setupCell(brand: brandArray[indexPath.item])
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
        let vc = ContentController.loadFromNib()
        let item = brandArray[indexPath.item]
        vc.brandContent = item
        navigationController?.pushViewController(vc, animated: true)
    }
}


