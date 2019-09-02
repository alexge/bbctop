//
//  AppDelegate.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Window
        let window = UIWindow()
        self.window = window
        
        let navigationController = UINavigationController()
        
        let headlinesController = HeadlinesController()

        navigationController.setViewControllers([headlinesController.initialViewController()], animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return true
    }
}

