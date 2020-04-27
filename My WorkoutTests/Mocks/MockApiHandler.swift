//
//  MockApiHandler.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 27/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Mock protocol to test the services
struct MockApiHandler: ApiHandlerProtocol {
    
    public var successResponse: Decodable?
    public var errorResponse: NetworkError
    public var url: URL?
    
    func get<ToDecode: Decodable>(_ url: URL, completionHandler: @escaping(Result<ToDecode, NetworkError>) -> Void) {
        switch successResponse {
        case .some(let response):
            if let correctResponse = response as? ToDecode {
                completionHandler(.success(correctResponse))
            } else {
                completionHandler(.failure(errorResponse))
            }
        default:
            completionHandler(.failure(errorResponse))
        }
    }
    
    func createRequest(host: String, path: String, defaultQueries: Bool?, queries: [String : String]?) -> URL? {
        return url
    }
}
