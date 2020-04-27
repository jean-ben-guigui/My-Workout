//
//  ExerciseImage.swift
//  My Workout
//
//  Created by Arthur Duver on 25/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// An exercise image as specified in the wger api model
struct ExerciseImage: WgerAPIEndpoint {
    let id: Int
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "image"
    }
}

extension ExerciseImage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ExerciseImage, rhs: ExerciseImage) -> Bool {
        return lhs.id == rhs.id
    }
}
