//
//  Exercise.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// An exercise as specified in the wger api model
struct Exercise: WgerAPIEndpoint {
    let id: Int
    let name: String
    let description: String
    let category: Int?
    let equipment: [Int]?
    let muscles: [Int]?
    let muscles_secondary: [Int]?
}

extension Exercise: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
