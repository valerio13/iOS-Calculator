//
//  AppDelegate.swift
//  iOS-Calculator
//
//  Created by Valerio Colantonio on 21/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Setup
        setupView()
        return true
    }
    
    // MARK: - Private Methods
    private func setupView(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
    }
}
