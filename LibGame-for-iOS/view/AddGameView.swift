//
//  AddGameView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI

struct AddGameView: View {
    var onReturnToDashboard: () -> Void
    
    @State private var _searchText: String = ""
    
    @EnvironmentObject private var _firebaseManager: FirebaseManager
    
    var body: some View {
        List(self._firebaseManager.games) { game in
            Text(game.title)
        }
        .searchable(text: self.$_searchText, prompt: "Search")
        .navigationTitle("Add Game")
    }
}
