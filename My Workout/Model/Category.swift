//
//  Category.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct Category: WgerAPIEndpoint {
    let id: Int
    let name: String
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
