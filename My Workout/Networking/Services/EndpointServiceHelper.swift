//
//  WgerService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct EndpointServiceHelper<Endpoint: WgerAPIEndpoint> {
    typealias Page = EndpointPage<Endpoint>
    
    private let apiHandler: ApiHandlerProtocol
    
    init(apiHandler: ApiHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    ///fetch and parse all the pages available
    func getPages(
        from url: URL,
        andAddItTo initialCategories: [Endpoint] = [],
        completionHandler: @escaping ((Result<[Endpoint], NetworkError>) -> Void)
    ) {
        var elements = initialCategories
        getNextPage(from: url) { (endpointPageResult) in
            switch endpointPageResult {
            case .success(let endpointPage):
                elements.append(contentsOf: endpointPage.elements)
                if let nextPageUrl = endpointPage.nextPageUrl {
                    self.getPages(from: nextPageUrl, andAddItTo: elements, completionHandler: completionHandler)
                } else {
                    completionHandler(.success(elements))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    ///fetch and parse a page
    func getNextPage(
        from url: URL,
        completionHandler: @escaping (((Result<Page, NetworkError>)) -> Void)
    ) {
        apiHandler.get(url) { (endpointPageResult: Result<Page, NetworkError>) in
            switch endpointPageResult {
            case .success(let endpointPage):
                completionHandler(.success(endpointPage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
