//
//  EndpointType.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: [String: Any?] { get }
}
