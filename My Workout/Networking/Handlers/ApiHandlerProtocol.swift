//
//  ApiHandlerProtocol.swift
//  My Workout
//
//  Created by Arthur Duver on 27/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

protocol ApiHandlerProtocol {
    func get<ToDecode: Decodable>(_ url: URL, completionHandler: @escaping(Result<ToDecode, NetworkError>) -> Void)
    func createRequest(
        host: String,
        path: String,
        defaultQueries: Bool?,
        queries: [String: String]?
    ) -> URL?
}
