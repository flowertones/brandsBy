//
//  TabBarController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let map = UINavigationController(rootViewController: MapController.loadFromNib())
        let brandList = UINavigationController(rootViewController: BrandListController.loadFromNib())
//        let shop = UINavigationController(rootViewController: ShopController.loadFromNib())
        let favorites = UINavigationController(rootViewController: FavoritesController.loadFromNib())
//        let brandList = BrandListController(nibName: String(describing: BrandListController.self), bundle: nil)
//        let shop = ShopController(nibName: String(describing: ShopController.self), bundle: nil)
//        let favorites = FavoritesController(nibName: String(describing: FavoritesController.self), bundle: nil)

        let configuration = UIImage.SymbolConfiguration(weight: .light)
        
        map.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house", withConfiguration: configuration), tag: 0)
        brandList.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass", withConfiguration: configuration), tag: 1)
//        shop.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bag", withConfiguration: configuration), tag: 2)
        favorites.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart", withConfiguration: configuration), tag: 3)
        
        self.viewControllers = [brandList, map, favorites]

    }
}
