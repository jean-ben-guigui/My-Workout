//
//  helper.swift
//  My Workout
//
//  Created by Arthur Duver on 25/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct ArrayHelper {
    func stringFromArray(_ array: [Int]?, using dictionnary: [Int: String]) -> String? {
        if let array = array, array.count > 0 {
            var string = ""
            for id in array {
                 if let value = dictionnary[id] {
                    string += ", \(value)"
                }
            }
            return string
        }
        return nil
    }
}

