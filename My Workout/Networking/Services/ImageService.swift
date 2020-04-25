//
//  ImageService.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct ImageService {
    
    func downloadPhoto(url: URL) -> UIImage? {
        var image: UIImage?
        let downloadSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = downloadSession.dataTask(with: url) { data, response, error in
            if let data = data {
                image = UIImage(data: data)
            }
        }
        return image
    }
}
