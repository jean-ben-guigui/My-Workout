//
//  Endpoint.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

protocol WgerAPIEndpoint: Decodable, Hashable {
    var id: Int { get }
}
