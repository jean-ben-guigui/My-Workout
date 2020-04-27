//
//  ImageService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

/// Fetches and download exercise images
struct ExerciseImageService {
    typealias ExerciseImagePage = EndpointPage<ExerciseImage>
    typealias ExerciseImageServiceHelper = EndpointServiceHelper<ExerciseImage>
    
    let apiHandler: ApiHandler
    let endpointServiceHelper: ExerciseImageServiceHelper
    
    init(apiHandler: ApiHandler = ApiHandler()) {
        self.apiHandler = apiHandler
        self.endpointServiceHelper = ExerciseImageServiceHelper(apiHandler: apiHandler)
    }
    
    /// Returns a random image for a given exercise or nil if there is no images for that exercise
    func getRandomImage(for exercise: Exercise, completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
        getAllImagesLink(for: exercise.id) {
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
    
    func getAllImages(for exercise: ExerciseViewModel, completionHandler: @escaping (Result<[UIImage], NetworkError>) -> Void) {
        getAllImagesLink(for: exercise.id) { (exerciseImageResult) in
            switch exerciseImageResult {
            case .success(let exercisesImage):
                var images = [UIImage]()
                let downloadGroup = DispatchGroup()
                for exerciseImage in exercisesImage {
                    downloadGroup.enter()
                    self.downloadImage(url: exerciseImage.url) {
                        switch $0 {
                        case.success(let image):
                            images.append(image)
                            downloadGroup.leave()
                        case .failure(_):
                            downloadGroup.leave()
                        }
                    }
                }
                downloadGroup.wait()
                completionHandler(.success(images))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //MARK: - FETCH LINKS
    
    /// Fetches all the url that allow to download images for a given exercises
    private func getAllImagesLink(for exerciseId: Int, completionHandler: @escaping (Result<[ExerciseImage], NetworkError>) -> Void) {
        let url = apiHandler.createRequest(
            host: Constants.wgerHost,
            path: Constants.Path.exerciseImage,
            queries: ["exercise": String(exerciseId)]
        )
        if let url = url {
            endpointServiceHelper.getPages(from: url) {
                completionHandler($0)
            }
        } else {
            completionHandler(.failure(.urlInit))
        }
    }
    
    //MARK: - DOWNLOAD
    
    /// Download an image for the given url
    func downloadImage(url: URL, completionHandler: @escaping (Result<(UIImage), NetworkError>) -> Void) {
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
