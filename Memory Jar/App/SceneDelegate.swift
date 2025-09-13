//
//  SceneDelegate.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 13.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = UITabBarController()
        
        // TabBar renklerini bal temasına ayarla ✨
        tabBarController.tabBar.tintColor = UIColor(hex: "#FF8F00")
        tabBarController.tabBar.unselectedItemTintColor = UIColor(hex: "#C4976C")
        tabBarController.tabBar.backgroundColor = UIColor(hex: "#F0EAE0")

        // TabBar'ı daha compact yap ✨
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#F0EAE0")

        // Title spacing'i ayarla
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)

        // Appearance'ı uygula
        tabBarController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        //Tabbarı yazıyoruz
        let homeVC = HomeViewController()
        homeVC.title = "Memory Jar"
        homeVC.tabBarItem = UITabBarItem(title: "Memory Jar", image: UIImage(systemName: "archivebox"), tag: 0)
        
        let memoriesVC = UIViewController()
        memoriesVC.title = "Memories"
        memoriesVC.tabBarItem = UITabBarItem(title: "Memories", image: UIImage(systemName: "heart.rectangle"), tag: 1)
        
        let settingsVC = UIViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 2)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let memoriesNav = UINavigationController(rootViewController: memoriesVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        //tabbara ekliyoruz
        tabBarController.viewControllers = [homeNav, memoriesNav, settingsNav]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

