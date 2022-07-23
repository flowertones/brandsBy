//
//  ListViewController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 5.07.22.
//

import UIKit
import Realm

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryBrand: [BrandContent] = []
    var categoryBrandRealm: [RealmContent] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        registerCells()
        setupNavigationButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryBrandRealm = RealmManager.read()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))
    }
    
    private func setupNavigationButton() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .label
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryBrand.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
        cell.setupCell(brand: categoryBrand[indexPath.item])
        cell.favorites = RealmContent(name: categoryBrand[indexPath.item].name)
        
        let favorites = categoryBrandRealm.first { $0.name == categoryBrand[indexPath.row].name}
        if favorites == nil {
            cell.favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            cell.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentVC = ContentController(nibName: String(describing: ContentController.self), bundle: nil)

        contentVC.brandContent = categoryBrand[indexPath.row]
        let favBrand = categoryBrandRealm.first { $0.name == categoryBrand[indexPath.row].name}
        if favBrand != nil {
            contentVC.favoritesButton.tag = 1
        }
        navigationController?.pushViewController(contentVC, animated: true)
    }
    
}

extension CategoryViewController: ReloadCell {
    func reloadCell() {
        categoryBrandRealm = RealmManager.read()
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 - 10, height: 270)
    }
}
