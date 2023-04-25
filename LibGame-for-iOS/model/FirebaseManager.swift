//
//  FirebaseDatabase.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 23/04/2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: ObservableObject {
    private let _database: Database
    private let _gamesRef: DatabaseReference
    private let _userGamesRef: DatabaseReference
    
    @Published var games = [Game]()
    private var _userGames = [Game]()
    @Published var userPlayingGames = [Game]()
    @Published var userPlayedGames = [Game]()
    
    init() {
        self._database = Database.database(url: AppConfig.DATABASE_URL)
        self._gamesRef = self._database.reference(withPath: "games")
        self._userGamesRef = self._database.reference(withPath: "user-games")
    }
    
    private func getGameById(for id: Int) -> Game {
        return self.games.first(where: { $0.id == id})!
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
                        status: Status.PLAYING
                    )
                    
                    self.games.append(game)
                }
            }
        })
    }
    
    func fetchUserGames(userId: String) {
        self._userGamesRef
            .child(userId)
            .observe(.value, with: { snapshot in
                self._userGames.removeAll()
                self.userPlayingGames.removeAll()
                self.userPlayedGames.removeAll()
                
                for child in snapshot.children {
                    if let dataSnapshot = child as? DataSnapshot,
                       let gameDict = dataSnapshot.value as? [String: Any],
                       let gameId = gameDict["gameId"] as? Int,
                       let status = gameDict["status"] as? String {
                        let enumStatus = Status(rawValue: status)!
                        
                        var game = self.getGameById(for: gameId)
                        game.status = enumStatus
                        
                        if enumStatus == Status.PLAYING {
                            self.userPlayingGames.append(game)
                        } else {
                            self.userPlayedGames.append(game)
                        }
                    }
                }
            })
    }
    
    func addGameToUser(userId: String, gameId: Int) -> Bool {
        if self._userGames.contains(where: { $0.id == gameId }) {
            return false
        }
        
        let userGame: [String: Any] = ["gameId": gameId, "status": Status.PLAYING.rawValue]
        
        self._userGamesRef
            .child(userId)
            .child("\(gameId)")
            .setValue(userGame)
        
        return true
    }
    
    func removeGameFromUser(userId: String, gameId: Int) {
        self._userGamesRef
            .child(userId)
            .child("\(gameId)")
            .removeValue()
    }
    
    func updateGameStatus(userId: String, gameId: Int, status: Status) {
        let userGame: [String: Any] = ["gameId": gameId, "status": status.rawValue]
        
        self._userGamesRef
            .child(userId)
            .child("\(gameId)")
            .setValue(userGame)
    }
}
