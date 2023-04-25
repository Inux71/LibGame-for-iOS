//
//  GameCard.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 24/04/2023.
//

import SwiftUI

struct GameCard: View {
    var isUserGame: Bool
    var game: Game
    var onReturnToDashboard: () -> Void
    var onAddGame: () -> Bool
    var onDeleteGame: () -> Void
    var onUpdateStatus: (_ status: Status) -> Void
    
    @State private var _selectedStatus: String
    
    init(
        isUserGame: Bool,
        game: Game,
        onReturnToDashboard: @escaping () -> Void,
        onAddGame: @escaping () -> Bool,
        onDeleteGame: @escaping () -> Void,
        onUpdateStatus: @escaping (_ status: Status) -> Void
    ) {
        self.isUserGame = isUserGame
        self.game = game
        self.onReturnToDashboard = onReturnToDashboard
        self.onAddGame = onAddGame
        self.onDeleteGame = onDeleteGame
        self.onUpdateStatus = onUpdateStatus
        
        self._selectedStatus = self.game.status!.rawValue
    }
    
    var body: some View {
        VStack {
            if isUserGame {
                HStack {
                    Spacer()
                    
                    Button(action: self.onDeleteGame) {
                        Image(systemName: "xmark")
                    }
                }
                .padding(.horizontal, 20)
            }
            
            AsyncImage(url: URL(string: game.thumbnail))
            
            HStack {
                VStack {
                    Text(game.title)
                        .fontWeight(.bold)
                    
                    Text(game.genre)
                        .font(.system(size: 10))
                }
                
                Spacer()
                
                if isUserGame {
                    VStack {
                        Picker("", selection: self.$_selectedStatus) {
                            ForEach(Status.allCases, id: \.rawValue) {
                                Text($0.rawValue)
                            }
                        }
                        .onChange(of: self._selectedStatus) { status in
                            self.onUpdateStatus(Status(rawValue: status)!)
                        }
                    }
                } else {
                    Button(action: {
                        if self.onAddGame() {
                            self.onReturnToDashboard()
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
    }
}
