//
//  ConnectXApp.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Initializes Firebase
        FirebaseApp.configure()
        return true
    }
}

@main
struct ConnectXApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
