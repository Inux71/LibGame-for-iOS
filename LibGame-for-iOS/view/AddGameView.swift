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
    
    var body: some View {
        VStack {
            
        }
        .searchable(text: self.$_searchText, prompt: "Search")
    }
}
