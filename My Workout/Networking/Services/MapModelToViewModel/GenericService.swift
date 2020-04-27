////
////  genericServic.swift
////  My Workout
////
////  Created by Arthur Duver on 27/04/2020.
////  Copyright © 2020 Arthur Duver. All rights reserved.
////
//
//import Foundation
//
//struct GenericService<Endpoint: WgerAPIEndpoint>: NetworkMapService {
//
//    typealias Page = EndpointPage<Endpoint>
//    typealias ServiceHelper = EndpointServiceHelper<Endpoint>
//
//    let apiHandler: ApiHandler
//    let endpointServiceHelper: ServiceHelper
//    let path: String
//    
//    init(path: String, apiHandler: ApiHandler = ApiHandler()) {
//        self.apiHandler = apiHandler
//        self.endpointServiceHelper = ServiceHelper(apiHandler: apiHandler)
//        self.path = path
//    }
//
//    func getAll(completionHandler: @escaping ((Result<[Endpoint], NetworkError>) -> Void)) {
//        let url = apiHandler.createRequest(host: Constants.wgerHost, path: Constants.Path.muscle)
//        if let url = url {
//            endpointServiceHelper.getPages(from: url, completionHandler: completionHandler)
//        } else {
//            completionHandler(.failure(.urlInit))
//        }
//    }
//
//    private func getPages(
//        from url: URL,
//        andAddItTo initialCategories: [Endpoint] = [],
//        completionHandler: @escaping ((Result<[Endpoint], NetworkError>) -> Void)
//    ) {
//        var elements = initialCategories
//        getNextPage(from: url) { (endpointPageResult) in
//            switch endpointPageResult {
//            case .success(let endpointPage):
//                elements.append(contentsOf: endpointPage.elements)
//                if let nextPageUrl = endpointPage.nextPageUrl {
//                    self.getPages(from: nextPageUrl, andAddItTo: elements, completionHandler: completionHandler)
//                } else {
//                    completionHandler(.success(elements))
//                }
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
//
//    ///fetch and parse a page
//    private func getNextPage(
//        from url: URL,
//        completionHandler: @escaping (((Result<Page, NetworkError>)) -> Void)
//    ) {
//        apiHandler.get(url) { (endpointPageResult: Result<Page, NetworkError>) in
//            switch endpointPageResult {
//            case .success(let endpointPage):
//                completionHandler(.success(endpointPage))
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
//}
