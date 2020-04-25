//
//  Exercise.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct Exercise: WgerAPIEndpoint {
    let id: Int
    let name: String?
    let category: Int?
    let equipment: [Int]?
    let muscles: [Int]?
    let muscles_secondary: [Int]?
    let description: String?
}

extension Exercise: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}
