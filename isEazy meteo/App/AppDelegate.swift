//
//  AppDelegate.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = WeatherViewController.newInstance()

        CoreDataController.shared.saveAPIKey()
        
        return true
    }
}
