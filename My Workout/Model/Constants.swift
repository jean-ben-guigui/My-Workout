//
//  Constants.swift
//  My Workout
//
//  Created by Arthur Duver on 22/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct Constants {
    static let wgerHost = "wger.de"
    struct Query {
        struct ApprovedExercisesQuery {
            static let name = "status"
            static let value = "2"
        }
        struct LanguageEnglishQuery {
            static let name = "language"
            static let value = "1"
        }
    }
    
    struct Path {
        static let exercise = "/api/v2/exercise/"
        static let category = "/api/v2/exercisecategory/"
        static let muscle = "/api/v2/muscle/"
        static let exerciseImage = "/api/v2/exerciseimage/"
    }
    
}
