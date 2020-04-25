//
//  ExerciseService.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

class ExerciseService {
    private let apiHandler: ApiHandler
    private let endpointServiceHelper: EndpointServiceHelper<Exercise>
    private var nextExercicesUrl: URL?
    
    init(apiHandler: ApiHandler) {
        self.apiHandler = apiHandler
        self.nextExercicesUrl = nil
        self.endpointServiceHelper = EndpointServiceHelper(apiHandler: apiHandler, parseHandler: ParseHandler<EndpointPage<Exercise>>())
    }
    
    func getNextExercises(completionHandler: @escaping ((Result<[Exercise], NetworkError>) -> Void)) {
        let url = nextExercicesUrl ??
            apiHandler.createRequest(
                host: Constants.wgerHost,
                path: Constants.path.exercise
        )
        if let url = url {
            endpointServiceHelper.getNextPage(from: url) {
                switch $0 {
                case .success(let page):
                    self.nextExercicesUrl = page.nextPageUrl
                    completionHandler(.success(page.elements))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
    
//    private func parseExercise(_ exercise: Data, completionHandler: ((Result<[Exercise], NetworkError>) -> Void)?) {
//        parseHandler.parseData(exercise) { [weak self] (EndpointPageResult) in
//            switch EndpointPageResult {
//            case .success(let EndpointPage):
//                self?.nextExercicesUrl = EndpointPage.nextPageUrl
//            case .failure(let error):
//                completionHandler?(.failure(error))
//            }
//        }
//    }
    
//    func getImagesLink(
//        exerciseId: Int,
//        completionHandler: @escaping ((Result<[String], NetworkError>) -> Void)) {
//        let queries = ["exercice": String(exerciseId)]
//        let url = apiHandler.createRequest(
//            host: "wger.de",
//            path: "/api/v2/exerciseimage/",
//            queries: queries
//        )
////        apiHandler.getData(
//    }
}
