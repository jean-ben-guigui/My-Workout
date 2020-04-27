//
//  Network.swift
//  My Workout
//
//  Created by Arthur Duver on 22/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Handle network requests
struct ApiHandler: ApiHandlerProtocol {
    ///Get data from a url and decode it
    func get<ToDecode: Decodable>(_ url: URL, completionHandler: @escaping(Result<ToDecode, NetworkError>) -> Void) {
        getData(url) {
            switch $0 {
            case .success(let data):
                let parseHandler = ParseHandler<ToDecode>()
                parseHandler.parseData(data) {
                    completionHandler($0)
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    ///Get data from a url
    private func getData(_ url: URL, completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    completionHandler(.success(data))
                } else if error != nil {
                    completionHandler(.failure(.noData))
                }
            }.resume()
        }
    
    ///Create a URL
    func createRequest(
        host: String,
        path: String,
        defaultQueries: Bool? = true,
        queries: [String: String]? = nil
    ) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if let defaultQueries = defaultQueries, defaultQueries {
            let ApprovedExercisesQuery = URLQueryItem(
                name: Constants.Query.ApprovedExercisesQuery.name,
                value: Constants.Query.ApprovedExercisesQuery.value
            )
            let englishQueryItem = URLQueryItem(
                name: Constants.Query.LanguageEnglishQuery.name,
                value: Constants.Query.LanguageEnglishQuery.value
            )
            components.queryItems = [ApprovedExercisesQuery, englishQueryItem]
        }
        
        if let queries = queries {
            if var queryItems = components.queryItems {
                for query in queries {
                    queryItems.append(URLQueryItem(name: query.key, value: query.value))
                }
                components.queryItems = queryItems
            } else {
                var queryItems = [URLQueryItem]()
                for query in queries {
                    queryItems.append(URLQueryItem(name: query.key, value: query.value))
                }
                components.queryItems = queryItems
            }
        }
        
        guard let url = components.url else {
            return nil
        }
        return url
    }
}

