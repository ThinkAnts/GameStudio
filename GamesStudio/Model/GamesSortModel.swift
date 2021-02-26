//
//  GamesSortModel.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import Foundation

class GamesSortModel: RequestModel {
    
    // MARK: - Properties
    private var sortParameters: String

    init(sortParameters: String) {
        self.sortParameters = sortParameters
    }
        
    override var path: String {
        return Constants.gamesUrl
    }
    
    override var parameters: [String : Any?] {
        return [
            "sort-by": sortParameters
        ]
    }
}
