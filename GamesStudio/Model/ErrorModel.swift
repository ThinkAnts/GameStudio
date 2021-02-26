//
//  ErrorModel.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import Foundation

class ErrorModel: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
    
    class func parsingError() -> ErrorModel {
        return ErrorModel(ErrorKey.parsing.rawValue)
    }
}
