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
    typealias MucleServiceHelper = EndpointServiceHelper<Muscle>
    
    let apiHandler: ApiHandler
    let parseHandler: ParseHandler<Muscle>
    let endpointServiceHelper: EndpointServiceHelper<Muscle>
    
    init(apiHandler: ApiHandler, parseHandler: ParseHandler<Muscle>) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.endpointServiceHelper = EndpointServiceHelper<Muscle>(apiHandler: apiHandler, parseHandler: ParseHandler<MusclePage>())
    }
    
    func getAll(completionHandler: @escaping ((Result<[Muscle], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.path.muscle)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        }
    }
}