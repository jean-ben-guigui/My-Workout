//
//  muscles.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct Muscle: WgerAPIEndpoint {
    let id: Int
    let name: String
}

extension Muscle: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Muscle, rhs: Muscle) -> Bool {
        return lhs.id == rhs.id
    }
}
