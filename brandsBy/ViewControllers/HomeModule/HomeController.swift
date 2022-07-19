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
            globalArrayBrand = brand
            print(self.brandArray.count)
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
