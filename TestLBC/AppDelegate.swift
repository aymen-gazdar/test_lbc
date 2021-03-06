//
//  AppDelegate.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)

        if #available(iOS 13.0, *) {
            // from iOS 13 we are using the SceneDelegate.swift

        } else {
            if let window = self.window {
                let splitViewController = UISplitViewController()
                splitViewController.viewControllers = [UINavigationController(rootViewController: AnnouncesListViewController())]
                splitViewController.preferredDisplayMode = .allVisible
                window.rootViewController = splitViewController
                window.makeKeyAndVisible()
                UINavigationBar.appearance().tintColor = UIColor.orange

            }
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

