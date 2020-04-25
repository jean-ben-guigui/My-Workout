//
//  Network.swift
//  My Workout
//
//  Created by Arthur Duver on 22/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct ApiHandler {    
    func getData(_ url: URL, completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
        
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    completionHandler(.success(data))
                } else if error != nil {
                    completionHandler(.failure(.noData))
                }
            }.resume()
        }
    
    func createRequest(host: String, path: String, queries: [String: String]? = nil ) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        let ApprovedExercisesQuery = URLQueryItem(
            name: Constants.Query.ApprovedExercisesQuery.name,
            value: Constants.Query.ApprovedExercisesQuery.value
        )
        let englishQueryItem = URLQueryItem(
            name: Constants.Query.LanguageEnglishQuery.name,
            value: Constants.Query.LanguageEnglishQuery.value
        )
        components.queryItems = [ApprovedExercisesQuery, englishQueryItem]
        
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

