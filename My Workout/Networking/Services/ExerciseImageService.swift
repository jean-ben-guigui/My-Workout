//
//  ImageService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct ExerciseImageService {
    typealias ExerciseImagePage = EndpointPage<ExerciseImage>
    typealias ExerciseImageServiceHelper = EndpointServiceHelper<ExerciseImage>
    
    let apiHandler: ApiHandler
    let endpointServiceHelper: ExerciseImageServiceHelper
    
    init(apiHandler: ApiHandler) {
        self.apiHandler = apiHandler
        self.endpointServiceHelper = ExerciseImageServiceHelper(apiHandler: apiHandler)
    }
    
    func getRandomImage(for exercise: Exercise, completionHandler: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        getAllImagesLink(for: exercise) {
            switch $0 {
            case .success(let exerciseImage):
                if let randomImageLink = exerciseImage.first {
                    self.downloadImage(url: randomImageLink.url) {
                        completionHandler($0)
                    }
                } else {
                    completionHandler(.failure(.noImage))
                }
            case .failure(_):
                completionHandler(.failure(.noImage))
            }
        }
    }
    
    func getAllImagesLink(for exercise: Exercise, completionHandler: @escaping (Result<[ExerciseImage], NetworkError>) -> Void) {
        let url = apiHandler.createRequest(
            host: Constants.wgerHost,
            path: Constants.Path.exerciseImage,
            queries: ["exercise": String(exercise.id)]
        )
        if let url = url {
            endpointServiceHelper.getPages(from: url) {
                completionHandler($0)
            }
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<(UIImage?), NetworkError>) -> Void) {
        let downloadSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = downloadSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler(.failure(.noData))
            }
            if let data = data {
                let image = UIImage(data: data)
                if let image = image {
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.downloadFailed))
                }
            }
        }
        dataTask.resume()
    }
}
