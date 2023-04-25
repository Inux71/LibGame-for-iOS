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
    
    @EnvironmentObject private var _firebaseManager: FirebaseManager
    
    private let _auth: Auth
    private let _user: User?
    
    private var _searchedGames: [Game] {
        if self._searchText.isEmpty {
            return self._firebaseManager.userGames
        } else {
            return self._firebaseManager.userGames.filter {
                $0.title.contains(self._searchText)
            }
        }
    }
    
    init(onNavigateToAddGame: @escaping () -> Void, onSignOut: @escaping () -> Void) {
        self.onNavigateToAddGame = onNavigateToAddGame
        self.onSignOut = onSignOut
        self._auth = Auth.auth()
        self._user = self._auth.currentUser
    }
    
    var body: some View {
        TabView {
            ScrollView {
                LazyVStack {
                    ForEach(self._searchedGames.filter { $0.status == Status.PLAYING }) { game in
                        GameCard(
                            isUserGame: true,
                            game: game,
                            onReturnToDashboard: {}
                        )
                    }
                }
            }
            .tabItem {
                Label("Playing", systemImage: "checklist.unchecked")
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(self._searchedGames.filter { $0.status == Status.PLAYED }) { game in
                        GameCard(
                            isUserGame: true,
                            game: game,
                            onReturnToDashboard: {}
                        )
                    }
                }
            }
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
