//
//  Service.swift
//  My Workout
//
//  Created by Arthur Duver on 27/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Network Service for endpoints that map the ids with the values of the exercises' attributes
protocol NetworkMapService {
    var apiHandler: ApiHandler {get}
    func getAll<T:WgerAPIEndpoint>(completionHandler: @escaping ((Result<[T], NetworkError>) -> Void))
}
