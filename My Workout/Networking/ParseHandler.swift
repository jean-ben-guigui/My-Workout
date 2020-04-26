//
//  ParseHandler.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct ParseHandler<DataType: Decodable> {
    func parseData(
        _ data: Data,
        completionHandler: @escaping (Result<DataType, NetworkError>) -> Void
    ) {
       do {
        let decodedData = try JSONDecoder().decode(DataType.self, from: data)
           completionHandler(.success(decodedData))
       } catch {
        completionHandler(.failure(.JSONDecoding(error)))
       }
    }
}
