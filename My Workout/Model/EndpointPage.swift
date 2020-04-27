//
//  paginatedElement.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// A page for a given endpoint of the wger api 
struct EndpointPage<Endpoint: WgerAPIEndpoint>: Decodable {
    var nextPageUrl: URL?
    var elements: [Endpoint]
    
    enum CodingKeys: String, CodingKey {
        case nextPageUrl = "next"
        case elements = "results"
    }
}
