//
//  SceneDelegate.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit
import GoogleMaps

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        GMSServices.provideAPIKey("AIzaSyAS6qgX2yi3HcDVg_Um0ScpBP4wkp3R5pM")

        GMSServices.provideAPIKey("AIzaSyCTp3RoyHfdMvjOulXWuLxSfi2EK-6Qqow")
        
        guard let windowScene = (scene as?  UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}

var globalArrayBrand: [BrandContent] = []

var global: ListSection = .categories([ListItem]()) {
    
    willSet {
        print(newValue)
    }
}
