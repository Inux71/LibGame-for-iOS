//
//  FirebaseUIAuthView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseEmailAuthUI

struct FirebaseUIAuthView: UIViewControllerRepresentable {
    var onNavigateToDashboard: () -> Void
    
    private let _providers: [FUIAuthProvider] = [FUIEmailAuth()]
    
    @EnvironmentObject private var _firebaseManager: FirebaseManager
    
    func makeUIViewController(context: Context) -> UIViewController {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = context.coordinator
        authUI?.providers = self._providers
        
        return authUI!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            onNavigateToDashboard: self.onNavigateToDashboard,
            fetchDataFromFirebase: {
                self._firebaseManager.fetchGames()
                self._firebaseManager.fetchUserGames(userId: Auth.auth().currentUser!.uid)
            }
        )
    }
    
    class Coordinator: NSObject, FUIAuthDelegate {
        let onNavigateToDashboard: () -> Void
        let fetchDataFromFirebase: () -> Void
        
        init(onNavigateToDashboard: @escaping () -> Void, fetchDataFromFirebase: @escaping () -> Void) {
            self.onNavigateToDashboard = onNavigateToDashboard
            self.fetchDataFromFirebase = fetchDataFromFirebase
        }
        
        func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
            if authDataResult?.user != nil {
                self.fetchDataFromFirebase()
                self.onNavigateToDashboard()
            }
        }
    }
}
