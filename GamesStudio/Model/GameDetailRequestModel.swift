//
//  GameDetailRequestModel.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import Foundation

class GameDetailRequestModel: RequestModel {
    
    // MARK: - Properties
    private var gameId: String

    init(gameId: String) {
        self.gameId = gameId
    }
    
    override var path: String {
        return Constants.gameUrl
    }

    override var parameters: [String : Any?] {
        return [
            "id": gameId
        ]
    }
}
