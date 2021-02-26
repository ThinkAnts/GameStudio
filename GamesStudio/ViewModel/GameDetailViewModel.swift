//
//  GameDetailViewModel.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import Foundation

class GameDetailViewModel {

    private let networking = Networking()
    private var gamesDetailModel: GameDetailModel?
    
    //MARK: Get All Games Based on release Date
    public func getGameDetails(_ gameId: String,
                             completion: @escaping(Swift.Result<String, ErrorModel>) -> Void) {
        networking.performNetworkTask(endpoint: GameDetailRequestModel(gameId: gameId),
                                      type: GameDetailModel.self) { [weak self] (response) in
            switch response {
            case .success(let gameDetail):
                self?.gamesDetailModel = gameDetail
                completion(.success(""))
            case .failure(_):
                print(ErrorModel.generalError())
            }
        }
    }
    
    public var gameDetails: GameDetailModel {
        return gamesDetailModel!
    }
}
