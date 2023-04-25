//
//  AddGameView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI
import FirebaseAuth

struct AddGameView: View {
    var onReturnToDashboard: () -> Void
    
    @State private var _searchText: String = ""
    
    private var _searchedGames: [Game] {
        if self._searchText.isEmpty {
            return self._firebaseManager.games
        } else {
            return self._firebaseManager.games.filter {
                $0.title.contains(self._searchText)
            }
        }
    }
    
    @EnvironmentObject private var _firebaseManager: FirebaseManager
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self._searchedGames) { game in
                    GameCard(
                        isUserGame: false,
                        game: game,
                        onReturnToDashboard: self.onReturnToDashboard,
                        onAddGame: {
                            self._firebaseManager.addGameToUser(userId: Auth.auth().currentUser!.uid, gameId: game.id)
                        },
                        onDeleteGame: {},
                        onUpdateStatus: {_ in }
                    )
                }
            }
        }
        .searchable(text: self.$_searchText, prompt: "Search")
        .navigationTitle("Add Game")
    }
}
