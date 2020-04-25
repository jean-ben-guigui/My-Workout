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
    
    private let apiHandler: ApiHandler
    private let parseHandler: ParseHandler<Page>
    
    init(apiHandler: ApiHandler, parseHandler: ParseHandler<Page>) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
    }
    
    // TODO implement it using getNextPage
    ///get the data of a page then parse it. If there is more than one page, does it recursively for each next pages.
    func getPages(
        from url: URL,
        andAddItTo initialCategories: [Endpoint] = [],
        completionHandler: @escaping ((Result<[Endpoint], NetworkError>) -> Void)
    ) {
        var categories = initialCategories
        apiHandler.getData(url) { (dataResult) in
            switch dataResult {
            case .success(let data):
                self.parseHandler.parseData(data) { (endpointPageResult) in
                    switch endpointPageResult {
                    case .success(let endpointPage):
                        categories.append(contentsOf: endpointPage.elements)
                        if let nextPageUrl = endpointPage.nextPageUrl {
                            self.getPages(from: nextPageUrl, andAddItTo: categories, completionHandler: completionHandler)
                        } else {
                            completionHandler(.success(categories))
                        }
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getNextPage(
        from url: URL,
        completionHandler: @escaping (((Result<Page, NetworkError>)) -> Void)
    ) {
        apiHandler.getData(url) { (dataResult) in
            switch dataResult {
            case .success(let data):
                self.parseHandler.parseData(data) { (endpointPageResult) in
                    switch endpointPageResult {
                    case .success(let endpointPage):
                        completionHandler(.success(endpointPage))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
