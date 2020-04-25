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
    let parseHandler: ParseHandler<Equipment>
    let endpointServiceHelper: EndpointServiceHelper<Equipment>
    
    init(apiHandler: ApiHandler, parseHandler: ParseHandler<Equipment>) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.endpointServiceHelper = EndpointServiceHelper<Equipment>(apiHandler: apiHandler, parseHandler: ParseHandler<EquipmentPage>())
    }
    
    func getAll(completionHandler: @escaping ((Result<[Equipment], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.muscle)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        }
    }
}
