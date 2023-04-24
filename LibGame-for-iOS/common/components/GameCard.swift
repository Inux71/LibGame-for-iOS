//
//  GameCard.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 24/04/2023.
//

import SwiftUI

struct GameCard: View {
    var game: Game
    var onReturnToDashboard: () -> Void
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.thumbnail))
            
            HStack() {
                VStack {
                    Text(game.title)
                        .fontWeight(.bold)
                    
                    Text(game.genre)
                        .font(.system(size: 10))
                }
                
                Spacer()
                
                Button(action: {
                    self.onReturnToDashboard()
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
    }
}
