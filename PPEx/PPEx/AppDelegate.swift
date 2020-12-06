//
//  AppDelegate.swift
//  PPEx
//
//  Created by Ben Leung on 3/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let currenciesController = CurrenciesViewConfigurator.config()
        let navController = UINavigationController(rootViewController: currenciesController)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }

}

