//
//  SceneDelegate.swift
//  Trendeye
//
//  Created by Arnaldo Rozon on 2/21/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let cameraViewController = CameraViewController()
        let homeNavigationController = UINavigationController(rootViewController: cameraViewController)
        homeNavigationController.view.backgroundColor = K.Colors.NavigationBar
        
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = homeNavigationController
        window?.makeKeyAndVisible()
        
        applyConfigurations()
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
        print("Entered foreground")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        print("Entered background")
    }
    
    
    // MARK: - Global Configurations
    
    fileprivate func applyConfigurations() {
        configureNavigationBar()
    }
    
    fileprivate func configureNavigationBar() {
        // MARK: - Fonts
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: AppFonts.Satoshi.font(face: .black, size: 30)!,
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: AppFonts.Satoshi.font(face: .black, size: 17)!
        ]
        
        // MARK: - Navigation Bar
        let iconSize: CGFloat = 18
        let backButton = UIImage(systemName: K.Icons.Back, withConfiguration: UIImage.SymbolConfiguration(pointSize: iconSize, weight: .semibold))
        UINavigationBar.appearance().barTintColor = K.Colors.NavigationBar
        UINavigationBar.appearance().tintColor = K.Colors.IconColor
        UINavigationBar.appearance().backIndicatorImage = backButton
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButton
        
        // BUG: Found a bug in UIKit! If large titles are set to true and this property is toggled to false and you double-tap the navigationBar to scroll back to the top of the scrollView, it creates extra space between the bottom of the navigationBar and the scrollView
         UINavigationBar.appearance().isTranslucent = false
         UINavigationBar.appearance().isOpaque = true
    }
    
}
