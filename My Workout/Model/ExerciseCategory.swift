//
//  ExerciseCategory.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// An category as specified in the wger api model
struct ExerciseCategory: WgerAPIEndpoint {
    let id: Int
    let name: String
}

extension ExerciseCategory: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ExerciseCategory, rhs: ExerciseCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
