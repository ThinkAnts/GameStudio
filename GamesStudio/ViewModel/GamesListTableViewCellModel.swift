//
//  GamesListTableViewCellModel.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import Foundation

class GamesListTableViewCellModel {

    private let gamesListModel: GamesListModel

    init(gamesListModel: GamesListModel) {
        self.gamesListModel = gamesListModel
    }

    var gameId: String {
        return String(gamesListModel.id)
    }

    var title: String {
        return gamesListModel.title
    }

    var shortDescription: String {
        return gamesListModel.short_description
    }

    var publisher: String {
        return gamesListModel.publisher
    }

    var thumbnail: String {
        return gamesListModel.thumbnail
    }
    
    var platform: String {
        return gamesListModel.platform
    }
    
    var category: String {
        return gamesListModel.genre
    }

}
