//
//  Game.swift
//  LibGame-for-iOS
//
//  Created by Kacper Grabiec on 23/04/2023.
//

import Foundation

struct Game: Identifiable {
    let id: Int
    let title: String
    let thumbnail: String
    let genre: String
    let status: Status?
}
