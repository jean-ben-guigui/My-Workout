//
//  CategoryService.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct CategoryService {
    typealias CategoryPage = EndpointPage<Category>
    typealias CategoryServiceHelper = EndpointServiceHelper<Category>
    
    let apiHandler: ApiHandler
    let parseHandler: ParseHandler<CategoryPage>
    let endpointServiceHelper: CategoryServiceHelper
    
    init(apiHandler: ApiHandler, parseHandler: ParseHandler<CategoryPage>) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.endpointServiceHelper = CategoryServiceHelper(apiHandler: apiHandler, parseHandler: parseHandler)
    }
    
    func getAll(completionHandler: @escaping ((Result<[Category], NetworkError>) -> Void)) {
        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.category)
        if let url = url {
            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
        } else {
            completionHandler(.failure(.urlInit))
        }
    }

}
