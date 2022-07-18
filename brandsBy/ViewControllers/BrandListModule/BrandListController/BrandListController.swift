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
    private var filteredBrand = [BrandContent]()
    private var brandNameArray = [String]()
    var brandRealm: [RealmContent] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private var sections = Sections.allCases
    private var categories = Category.allCases
    private var filterText = ["СОРТИРОВАТЬ", "ФИЛЬТРЫ"]
    private let searchController = UISearchController()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.contentInsetAdjustmentBehavior = .never
        searchController.searchResultsUpdater = self
        initSearchController()
        
        NetworkManager.getBrand { brand in
            self.brandArray = brand
            globalArrayBrand = brand
            print(self.brandArray.count)
//            var allCategories = [String]()
//            brand.forEach({ $0.categories.forEach({ allCategories.append($0)})})
//            print(Set(allCategories.map({$0})))
//            let mySet = Set<String>()
//            let myList = Array(mySet.union(allCategories.map({$0}))).map({ ListItem(title: $0, image: "")})
//            global = ListSection.categories(myList)
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
//        configureNavbar()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        brandRealm = RealmManager.read()
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .filters:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute( self.view.frame.width / 2), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(40)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                
                return section
                
            case .category:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(130), heightDimension: .absolute(25)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                return section
                
            case .countBrand:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(20)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 10, leading: 0, bottom: 20, trailing: 0)
            
                return section
                
            case .content:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute( self.view.frame.width / 2 - 10), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(270)), subitems: [item])
                group.interItemSpacing = .fixed(20)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                return section
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
    }
    
//    private func configureNavbar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
//
////        navigationController?.navigationBar.tintColor = .label
//    }
    
//    @objc func search() {
//        navigationItem.searchController = searchController
//        title = "Поиск"
//    }
    
    private func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
//        brandArray.forEach({ $0.name.forEach({ brandNameArray.append($0)})})
        for brand in brandArray {
            brandNameArray.append(brand.name)
        }
        searchController.searchBar.delegate = self
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
            return categories.count
        case .countBrand:
            return 1
        case .content:
            if isFiltering {
                return filteredBrand.count
            }
            return brandArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .filters:
            let filerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            filerCell.categoryLabel.text = filterText[indexPath.item]
//            filerCell.categoryLabel.layer.borderWidth = 0.5
//            filerCell.categoryLabel.layer.borderColor = UIColor.lightGray.cgColor
            return filerCell
            
        case .category:
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            categoryCell.setupCategory(category: categories[indexPath.item])
//            categoryCell.categoryLabel.layer.cornerRadius = categoryCell.categoryLabel.frame.height / 2
//            categoryCell.categoryLabel.layer.borderWidth = 0.6
//            categoryCell.categoryLabel.layer.borderColor = UIColor.darkGray.cgColor
            return categoryCell
    
        case .countBrand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            
            var countBrandLabel = ""
            let firstDeclension = [1, 21, 31, 41, 51, 61, 71]
            let secondDeclension = [2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44, 52, 53, 54, 62, 63, 64]
            
            if  let _ = firstDeclension.filter({ $0 == brandArray.count}).first {
                countBrandLabel = "бренд"
            } else if let _ = secondDeclension.filter({ $0 == brandArray.count }).first {
                countBrandLabel = "бренда"
            } else {
                countBrandLabel = "брендов"
            }

            if isFiltering {
                if  let _ = firstDeclension.filter({ $0 == filteredBrand.count }).first {
                    countBrandLabel = "бренд"
                } else if let _ = secondDeclension.filter({ $0 == filteredBrand.count }).first {
                    countBrandLabel = "бренда"
                } else {
                    countBrandLabel = "брендов"
                }
                
                cell.categoryLabel.text = "\(filteredBrand.count) \(countBrandLabel)"
                
            }
            
            cell.categoryLabel.text = "\(brandArray.count) \(countBrandLabel)"
            return cell
            
        case .content:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
            if isFiltering {
                cell.setupCell(brand: filteredBrand[indexPath.item])
            } else {
            cell.setupCell(brand: brandArray[indexPath.item])
            }
            
            cell.favorites = RealmContent(name: brandArray[indexPath.item].name)
            
            let favorites = brandRealm.first { $0.name == brandArray[indexPath.row].name}
            if favorites == nil {
                cell.favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.favoritesButton.tag = 0
            } else {
                cell.favoritesButton.tag = 1
                cell.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            
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
        switch sections[indexPath.section] {
        case .filters :
        
            let vc = FiltersViewController.loadFromNib()
            vc.brandArray = brandArray
            vc.title = filterText[indexPath.item].lowercased()
            navigationController?.pushViewController(vc, animated: true)

        case .category:

            func categoryFilter(brand: BrandContent ) -> Bool {
                var result = false
                for cat in brand.categories {
                    if cat == categories[indexPath.item].rawValue {
                    result = true
                    }
                }
                return result
            }
            
            let categoryBrand = brandArray.filter(categoryFilter)
        
            let categoryVC = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
            categoryVC.categoryBrand = categoryBrand
            categoryVC.title = "\(categories[indexPath.row].rawValue)"
            navigationController?.pushViewController(categoryVC, animated: true)

        case .content:
            let vc = ContentController.loadFromNib()
            let item = brandArray[indexPath.item]
            vc.brandContent = item
            let favBrand = brandRealm.first { $0.name == item.name}
            if favBrand != nil {
                vc.isFavorite = true
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
}

extension BrandListController: ReloadCell {
    func reloadCell() {
        brandRealm = RealmManager.read()
    }
}

extension BrandListController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        filterContentForSearchText(text)
        collectionView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredBrand = brandArray.filter({ (brand: BrandContent) -> Bool in
            return brand.name.lowercased().contains(searchText.lowercased())
        })

    }
    


}


