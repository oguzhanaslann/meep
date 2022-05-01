//
//  SceneDelegate.swift
//  meep
//
//  Created by Oğuzhan Aslan on 12.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
    let PEOPLE_PAGE_INDEX = 0
    let SEARCH_PAGE_INDEX = 1
    let PROFILE_PAGE_INDEX = 2
   
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds )
        window?.windowScene = windowScene
                
        let rootViewController = UITabBarController()
        initTabBarController(tabbarController: rootViewController)
        
        let navController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    private func initTabBarController(tabbarController : UITabBarController) {
        let personListVC = PersonListViewController()
        let personSearchVC = PersonSearchViewController()
        let profileVC = ProfileViewController()
        tabbarController.viewControllers = [personListVC,personSearchVC,profileVC]
    
        tabbarController.tabBar.items?[PEOPLE_PAGE_INDEX].title = "People"
        tabbarController.tabBar.items?[PEOPLE_PAGE_INDEX].image = UIImage(systemName: "house")
      
        tabbarController.tabBar.items?[SEARCH_PAGE_INDEX].title = "Search"
        tabbarController.tabBar.items?[SEARCH_PAGE_INDEX].image = UIImage(systemName: "magnifyingglass")
    
        tabbarController.tabBar.items?[PROFILE_PAGE_INDEX].title = "Profile"
        tabbarController.tabBar.items?[PROFILE_PAGE_INDEX].image = UIImage(systemName: "person.fill")
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
    }


}
