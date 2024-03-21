//
//  AppDelegate.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 19.03.2024.
//

import UIKit
import ParseUI
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration { ParseMutableClientConfiguration in
            ParseMutableClientConfiguration.applicationId = "ynYeeJW6mcan4MHSkqofld58V5gjWyvWRsdc29Th"
            ParseMutableClientConfiguration.clientKey = "6cwMUTeyHTTHdAYPbnN8HNEVa5nW4HzUZidHc6yG"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
        }
        
        Parse.initialize(with: configuration)
        
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

