//
//  FirebaseDatabase.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 23/04/2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class FirebaseManager: ObservableObject {
    private let _database: Database
    private let _gamesRef: DatabaseReference
    private let _userGamesRef: DatabaseReference
    
    @Published var games = [Game]()
    
    init() {
        self._database = Database.database(url: AppConfig.DATABASE_URL)
        self._gamesRef = self._database.reference(withPath: "games")
        self._userGamesRef = self._database.reference(withPath: "user-games")
    }
    
    func fetchGames() {
        self._gamesRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let dataSnapshot = child as? DataSnapshot,
                   let gameDict = dataSnapshot.value as? [String: Any],
                   let id = gameDict["id"] as? Int,
                   let title = gameDict["title"] as? String,
                   let thumbnail = gameDict["thumbnail"] as? String,
                   let genre = gameDict["genre"] as? String {
                    let game = Game(
                        id: id,
                        title: title,
                        thumbnail: thumbnail,
                        genre: genre,
                        status: nil
                    )
                    
                    self.games.append(game)
                }
            }
        })
    }
}
