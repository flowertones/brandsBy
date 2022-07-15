//
//  FavoritesController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class FavoritesController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
//    var favorites = RealmManager.read() {
    var favorites: [RealmContent] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var brandContent: BrandContent?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        readData()
        favorites.removeAll()
        favorites = RealmManager.read()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))
    }
    
//    private func readData() {
//        guard let brandContent = brandContent else {
//            return
//        }
//
//        self.favorites = RealmManager.read().filter({ $0.id == brandContent.id})
//    }


}


extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BrandCollectionViewCell.self), for: indexPath)
        guard let brandCell = cell as? BrandCollectionViewCell else { return cell }
        
//
//        var brandArray: [BrandContent] = []
//
//        for brand in 0...favorites.count - 1 {
//            let id = favorites[brand].id
//            if let brand = globalArrayBrand.first(where: { $0.id == id}) {
//                brandArray.append(brand)
//            }
//        }
//
        brandCell.setupFavoriteCell(brand: favorites[indexPath.item])
        
        
        
//        brandCell.brandNameLabel.text = "\(favorites[indexPath.item].name)"
//        brandCell.brandImageView.image = UIImage(named: "image2")

        brandCell.favoritesButton.tag = 1
        if DefaultsManager.favorites {
            brandCell.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

        if DefaultsManager.notFavorites {
            brandCell.favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
//        brandCell.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        brandCell.deleteThisCell = { [weak self] in
            RealmManager.delete(object: (self?.favorites[indexPath.item])!)
            self?.favorites = RealmManager.read()
         }
        return cell
    }
}

extension FavoritesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = ContentController.loadFromNib()
//        let item = brandArray[indexPath.item]
//        vc.brandContent = item
//        navigationController?.pushViewController(vc, animated: true)
    }
}
