//
//  ExerciseService.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

class ExerciseService {
    private let apiHandler: ApiHandler
    private let endpointServiceHelper: EndpointServiceHelper<Exercise>
    private var nextExercisesUrl: URL?
    
    init(apiHandler: ApiHandler) {
        self.apiHandler = apiHandler
        self.nextExercisesUrl = nil
        self.endpointServiceHelper = EndpointServiceHelper(apiHandler: apiHandler, parseHandler: ParseHandler<EndpointPage<Exercise>>())
    }
    
    func getNextExercises(completionHandler: @escaping ((Result<[Exercise], NetworkError>) -> Void)) {
        let url = nextExercisesUrl ??
            apiHandler.createRequest(
                host: Constants.wgerHost,
                path: Constants.Path.exercise
        )
        if let url = url {
            endpointServiceHelper.getNextPage(from: url) {
                switch $0 {
                case .success(let page):
                    self.nextExercisesUrl = page.nextPageUrl
                    completionHandler(.success(page.elements))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
}
