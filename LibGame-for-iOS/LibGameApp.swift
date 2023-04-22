//
//  LibGame_for_iOSApp.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI

@main
struct LibGameApp: App {
    @UIApplicationDelegateAdaptor(LibGameAppDelegate.self) var delegate
    
    @State private var _path: [String] = []
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$_path) {
                LoginView(
                    onNavigateToDashboard: {
                        self._path.append("dashboard")
                    },
                    onNavigateToFirebaseUIAuth: {
                        self._path.append("auth")
                    }
                )
                .navigationDestination(for: String.self) { path in
                    self.getDestination(for: path)
                }
            }
        }
    }
    
    private func getDestination(for path: String) -> AnyView {
        switch path {
            case "auth":
                return AnyView(FirebaseUIAuthView(onNavigateToDashboard: {
                    self._path.append("dashboard")
                }))
            case "dashboard":
                return AnyView(DashboardView(
                    onNavigateToAddGame: {
                        self._path.append("add")
                    },
                    onSignOut: {
                        self._path.removeAll()
                    }
                ))
            case "add":
                return AnyView(AddGameView(onReturnToDashboard: {
                    self._path.removeLast()
                }))
            default:
                return AnyView(EmptyView())
        }
    }
}
