//
//  DashboardView.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 22/04/2023.
//

import SwiftUI

struct DashboardView: View {
    var onNavigateToAddGame: () -> Void
    var onSignOut: () -> Void
    
    @State private var _searchText: String = ""
    
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
        .navigationTitle("Kacper Grabiec")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button(action: self.onNavigateToAddGame) {
                Image(systemName: "plus")
            }
            
            Button(action: self.onSignOut) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
        }
        .searchable(text: self.$_searchText, prompt: "Search")
    }
}
