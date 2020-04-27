//
//  Equipment.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct EquipmentService {
    typealias EquipmentPage = EndpointPage<Equipment>
    typealias EquipmentServiceHelper = EndpointServiceHelper<Equipment>
    
    let apiHandler: ApiHandler
    let endpointServiceHelper: EndpointServiceHelper<Equipment>
    
    init(apiHandler: ApiHandler = ApiHandler()) {
        self.apiHandler = apiHandler
        self.endpointServiceHelper = EndpointServiceHelper<Equipment>(apiHandler: apiHandler)
    }
    
    func getAll(completionHandler: @escaping ((Result<[Equipment], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.equipment)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
}
