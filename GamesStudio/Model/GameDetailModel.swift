//
//  GameDetailModel.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import Foundation

struct GameDetailModel: Codable {
    // MARK: - Properties
    var id: Int
    var title: String
    var thumbnail: String
    var short_description: String
    var description: String
    var game_url: String
    var genre: String
    var platform: String
    var publisher: String
    var developer: String
    var release_date: String
    var freetogame_profile_url: String
    var screenshots: [GameScreenShots]
}

struct GameScreenShots: Codable {
    var id: Int
    var image: String
}
