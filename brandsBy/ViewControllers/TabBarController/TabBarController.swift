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
        let favorites = UINavigationController(rootViewController: FavoritesController.loadFromNib())

        let configuration = UIImage.SymbolConfiguration(weight: .light)
            
        map.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house", withConfiguration: configuration), tag: 0)
        brandList.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass", withConfiguration: configuration), tag: 1)
        favorites.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart", withConfiguration: configuration), tag: 3)
        
        self.tabBar.tintColor = .darkPeach
        
        self.viewControllers = [brandList, map, favorites]
    }
}
