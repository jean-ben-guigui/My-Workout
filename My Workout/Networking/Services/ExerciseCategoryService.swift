//
//  ExerciseCategoryService.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Fetches categories
struct ExerciseCategoryService {
    typealias ExerciseCategoryPage = EndpointPage<ExerciseCategory>
    typealias ExerciseCategoryServiceHelper = EndpointServiceHelper<ExerciseCategory>
    
    let apiHandler: ApiHandlerProtocol
    let endpointServiceHelper: ExerciseCategoryServiceHelper
    
    init(apiHandler: ApiHandlerProtocol = ApiHandler()) {
        self.apiHandler = apiHandler
        self.endpointServiceHelper = ExerciseCategoryServiceHelper(apiHandler: apiHandler)
    }
    
    func getAll(completionHandler: @escaping ((Result<[ExerciseCategory], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.category, defaultQueries: nil, queries: nil)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        } else {
            completionHandler(.failure(.urlInit))
        }
    }

}
