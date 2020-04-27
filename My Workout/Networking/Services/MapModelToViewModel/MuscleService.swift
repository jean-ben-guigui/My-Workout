//
//  MuscleService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct MuscleService {
    typealias MusclePage = EndpointPage<Muscle>
    typealias MuscleServiceHelper = EndpointServiceHelper<Muscle>
    
    let apiHandler: ApiHandler
    let endpointServiceHelper: MuscleServiceHelper
    
    init(apiHandler: ApiHandler = ApiHandler()) {
        self.apiHandler = apiHandler
        self.endpointServiceHelper = MuscleServiceHelper(apiHandler: apiHandler)
    }
    
    func getAll(completionHandler: @escaping ((Result<[Muscle], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.muscle)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
}
