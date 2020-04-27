//
//  WgerService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Fetch and parse data for a given endpoint
struct EndpointServiceHelper<Endpoint: WgerAPIEndpoint> {
    typealias Page = EndpointPage<Endpoint>
    
    private let apiHandler: ApiHandlerProtocol
    
    init(apiHandler: ApiHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    /// Fetch and parse all the pages availables for a given url
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
    
    /// Fetch and parse a page for a given url
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
