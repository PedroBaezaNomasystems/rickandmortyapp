//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 14/10/25.
//

import UIKit
import SwiftUI
import Presentation

@main
struct RickAndMortyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                
                CharacterListView(router: router)
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .list:
                            CharacterListView(router: router)
                        case let .character(characterId):
                            CharacterDetailView(router: router, characterId: characterId)
                        }
                    }
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }
}
