//
//  DashboardView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI
import FirebaseAuthUI

struct DashboardView: View {
    var onNavigateToAddGame: () -> Void
    var onSignOut: () -> Void
    
    @State private var _searchText: String = ""
    
    private let _auth: Auth
    private let _user: User?
    
    init(onNavigateToAddGame: @escaping () -> Void, onSignOut: @escaping () -> Void) {
        self.onNavigateToAddGame = onNavigateToAddGame
        self.onSignOut = onSignOut
        self._auth = Auth.auth()
        self._user = self._auth.currentUser
    }
    
    var body: some View {
        TabView {
            Text("playing")
                .tabItem {
                    Label("Playing", systemImage: "checklist.unchecked")
                }
            
            Text("played")
                .tabItem {
                    Label("Played", systemImage: "checklist.checked")
                }
        }
        .navigationTitle(self._user?.displayName ?? "")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button(action: self.onNavigateToAddGame) {
                Image(systemName: "plus")
            }
            
            Button(action: {
                do {
                    try self._auth.signOut()
                    self.onSignOut()
                } catch {
                    
                }
            }) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
        }
        .searchable(text: self.$_searchText, prompt: "Search")
    }
}
