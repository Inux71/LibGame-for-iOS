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
    
    func makeUIViewController(context: Context) -> UIViewController {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = context.coordinator
        authUI?.providers = self._providers
        
        return authUI!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onNavigateToDashboard: self.onNavigateToDashboard)
    }
    
    class Coordinator: NSObject, FUIAuthDelegate {
        let onNavigateToDashboard: () -> Void
        
        init(onNavigateToDashboard: @escaping () -> Void) {
            self.onNavigateToDashboard = onNavigateToDashboard
        }
        
        func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
            if authDataResult?.user != nil {
                self.onNavigateToDashboard()
            }
        }
    }
}
