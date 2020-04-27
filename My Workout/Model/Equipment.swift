//
//  Equipment.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// An equipment as specified in the wger api model
struct Equipment: WgerAPIEndpoint {
    let id: Int
    let name: String
}

extension Equipment: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Equipment, rhs: Equipment) -> Bool {
        return lhs.id == rhs.id
    }
}
