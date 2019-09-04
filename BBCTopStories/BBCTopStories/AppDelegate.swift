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
    let headlinesFlow = HeadlinesFlowController()
    let headlinesNav = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Window
        let window = UIWindow()
        self.window = window
        
        headlinesNav.setViewControllers([headlinesFlow.initialViewController()], animated: false)
        
        // Biometric login
        let biometricVC = BiometricLoginViewController()
        biometricVC.successHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.window?.rootViewController = self?.headlinesNav
            }
        }
        window.rootViewController = biometricVC
        window.makeKeyAndVisible()
        
        return true
    }
}

