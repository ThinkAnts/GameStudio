//
//  GamesListTableViewModel.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import Foundation

class GamesListTableViewModel {

    private let networking = Networking()
    private var gamesListModel: [GamesListModel] = []

    public func cellViewModel(index: Int) -> GamesListTableViewCellModel? {
        let gamesListTableViewCellModel = GamesListTableViewCellModel(gamesListModel: gamesListModel[index])
        return gamesListTableViewCellModel
    }
    
    public var count: Int {
        return gamesListModel.count
    }
    
    public func gameId(index: Int) -> String {
      let gamesListTableViewCellModel = GamesListTableViewCellModel(gamesListModel: gamesListModel[index])
      return gamesListTableViewCellModel.gameId
    }
}

extension GamesListTableViewModel {
    //MARK: Get All Games Based on release Date
    public func getGamesList(_ queryValue: String,
                             completion: @escaping(Swift.Result<String, ErrorModel>) -> Void) {
        networking.performNetworkTask(endpoint: GamesSortModel(sortParameters: queryValue),
                                      type: [GamesListModel].self) { [weak self] (response) in
            switch response {
            case .success(let gamesList):
                self?.gamesListModel = gamesList
                completion(.success(""))
            case .failure(_):
                print(ErrorModel.generalError())
            }
        }
    }
    
    public func filterGames(_ filters: [String: String],
                             completion: @escaping(Swift.Result<String, ErrorModel>) -> Void) {
        networking.performNetworkTask(endpoint: GamesFilterModel(filterParameters: filters),
                                      type: [GamesListModel].self) { [weak self] (response) in
            switch response {
            case .success(let gamesList):
                self?.gamesListModel = gamesList
                completion(.success(""))
            case .failure(_):
                print(ErrorModel.generalError())
            }
        }
    }
}
