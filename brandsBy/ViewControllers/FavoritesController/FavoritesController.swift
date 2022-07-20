//
//  FavoritesController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit
import SDWebImage

class FavoritesController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
        
    var favorites: [RealmContent] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var brandContent: BrandContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "избранное"
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites.removeAll()
        favorites = RealmManager.read()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))
    }
}

extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BrandCollectionViewCell.self), for: indexPath)
        guard let brandCell = cell as? BrandCollectionViewCell else { return cell }
        brandCell.setupFavoriteCell(brand: favorites[indexPath.item])
        brandCell.favoritesButton.tag = 1
        brandCell.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        brandCell.deleteThisCell = { [weak self] in
            RealmManager.delete(object: (self?.favorites[indexPath.item])!)
            self?.favorites = RealmManager.read()
         }
        return cell
    }
}

extension FavoritesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ContentController.loadFromNib()
        let brand = globalArrayBrand.first{ $0.name == favorites[indexPath.row].name}
        vc.brandContent = brand
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 - 10, height: 270)
    }
}
