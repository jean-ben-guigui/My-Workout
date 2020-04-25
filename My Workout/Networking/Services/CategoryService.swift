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
            getPages(from: url) {
                completionHandler($0)
            }
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
    
    ///get the data of a page then parse it. If there is more than one page, does it recursively for each next pages.
    private func getPages(
        from url: URL,
        andAddItTo initialCategories: [Category] = [],
        completionHandler: @escaping ((Result<[Category], NetworkError>) -> Void)
    ) {
        var categories = initialCategories
        apiHandler.getData(url) { (dataResult) in
            switch dataResult {
            case .success(let data):
                self.parseHandler.parseData(data) { (categoryPageResult) in
                    switch categoryPageResult {
                    case .success(let categoryPage):
                        categories.append(contentsOf: categoryPage.elements)
                        if let nextPageUrl = categoryPage.nextPageUrl {
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
}
