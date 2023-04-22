//
//  LoginView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI

struct LoginView: View {
    var onNavigateToDashboard: () -> Void
    
    var body: some View {
        VStack {
            Text("LibGame")
                .font(.system(size: 32, weight: .bold))
            
            Button("Sign In") {
                self.onNavigateToDashboard()
            }
        }
        .buttonStyle(.borderedProminent)
    }
}
