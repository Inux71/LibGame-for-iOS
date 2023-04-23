//
//  LoginView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI
import FirebaseAuthUI

struct LoginView: View {
    var onNavigateToDashboard: () -> Void
    var onNavigateToFirebaseUIAuth: () -> Void
    
    @EnvironmentObject private var _firebaseManager: FirebaseManager
    
    var body: some View {
        VStack {
            Text("LibGame")
                .font(.system(size: 32, weight: .bold))
            
            Button("Sign In") {
                if Auth.auth().currentUser != nil {
                    self._firebaseManager.fetchGames()
                    self.onNavigateToDashboard()
                } else {
                    self.onNavigateToFirebaseUIAuth()
                }
            }
        }
        .buttonStyle(.borderedProminent)
    }
}
