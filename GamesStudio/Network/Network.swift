//
//  Network.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import Foundation

struct Networking {

    func performNetworkTask<T: Codable>(endpoint: RequestModel,
                                        type: T.Type,
                                        completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {        
        let urlSession = URLSession.shared.dataTask(with: endpoint.urlRequest()) { (data, urlResponse, error) in
            if let _ = error {
                completion(.failure(ErrorModel.generalError()))
                return
            }
            guard let data = data else {
                completion(.failure(ErrorModel.generalError()))
                return
            }
            
            let response = Response(data: data)
            guard let decodedData = response.decode(type) else {
                completion(.failure(ErrorModel.parsingError()))
                return
            }
            completion(.success(decodedData))
        }
        urlSession.resume()
    }

}
