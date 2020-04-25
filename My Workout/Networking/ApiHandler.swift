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
        if let queries = queries {
            for query in queries {
                components.queryItems?.append(URLQueryItem(name: query.key, value: query.value))
            }
        }
        components.path = path
        guard let url = components.url else {
            return nil
        }
        return url
    }
}

