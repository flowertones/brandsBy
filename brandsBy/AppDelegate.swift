//
//  AppDelegate.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit
import RevealingSplashView


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "bIcon")!, iconInitialSize: CGSize(width: 120 * UIScreen.main.bounds.width / 414.0, height: 120 * UIScreen.main.bounds.width / 414.0), backgroundColor: .white)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        revealingSplashView.startAnimation()
        window?.rootViewController?.view.addSubview(revealingSplashView)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

