//
//  HomeController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class HomeController: UIViewController {
    
    //    var brandContent: BrandContent?
    var categories = [""]
    var brandArray = [BrandContent]()
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        
        NetworkManager.getBrand { brand in
            self.brandArray = brand
            var allCategories = [String]()
            brand.forEach({ $0.categories.forEach({ allCategories.append($0)})})
            print(Set(allCategories.map({$0})))
//            let myList = Array(Set<String>().union(allCategories.map({$0}))).map({ ListItem(title: $0, image: "")})
//            globalCategories = ListSection.categories(myList)
            globalCategories = Array(Set<String>().union(allCategories.map({$0})))

            self.popularCollectionView.reloadData()
        } failureBlock: {
            print("Error")
        }
        
        registerCells()
    }
    
    private func registerCells() {
        popularCollectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))
    }
}


extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BrandCollectionViewCell.self), for: indexPath)
        guard let brandCell = cell as? BrandCollectionViewCell else { return cell }
        
        brandCell.setupCell(brand: brandArray[indexPath.row])
        return brandCell
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ContentController(nibName: String(describing: ContentController.self), bundle: nil)
        let item = brandArray[indexPath.row]
        vc.brandContent = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
