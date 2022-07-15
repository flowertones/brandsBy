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

//        NetworkManager.getBrand { [weak self] result in
//            guard let self = self else { return }
//            self.nameLabel.text = result.name
//            self.categories = result.categories ?? []
//            self.brandArray.append(result)
//            print(self.categories)
            
//            NetworkManager.getBrand { [weak self] result in
//                guard let self = self else { return }
//                print("okey")
//                self.brandArray = result
//
//            } failureBlock: {
//                print("oshibka")
//            }
  
        NetworkManager.getBrand { brand in
            self.brandArray = brand
            globalArrayBrand = brand
            print(self.brandArray.count)
            var allCategories = [String]()
            brand.forEach({ $0.categories.forEach({ allCategories.append($0)})})
            print(Set(allCategories.map({$0})))
            let mySet = Set<String>()
            let myList = Array(mySet.union(allCategories.map({$0}))).map({ ListItem(title: $0, image: "")})
            global = ListSection.categories(myList)
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

        brandCell.setupCell(brand: brandArray[indexPath.item])
        return brandCell
    }
    
    
    
    
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ContentController.loadFromNib()
        let item = brandArray[indexPath.item]
        vc.brandContent = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
