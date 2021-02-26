//
//  GamesFilterModel.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import Foundation

class GamesFilterModel: RequestModel {
    
    // MARK: - Properties
    private var filterParameters: [String: String]

    init(filterParameters: [String: String]) {
        self.filterParameters = filterParameters
    }
        
    override var path: String {
        return Constants.gamesUrl
    }
    
    override var parameters: [String : Any?] {
        let filterType = filterParameters["filter"]
        if(filterType == "platform") {
            return [
                "platform": filterParameters["filterName"],
                "sort-by": filterParameters["sort"]
            ]
        } else {
            return [
                "category": filterParameters["filterName"],
                "sort-by": filterParameters["sort"]
            ]
        }
    }
}

