//
//  exerciseDescriptionHelper.swift
//  My Workout
//
//  Created by Arthur Duver on 25/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

struct MapModelToViewModelHelper {
    func getTextTodisplay(for name: String, from array: [Int]?, using dictionnary: [Int: String]) -> String? {
        if let array = array, array.count > 0 {
            var string = "\(name): "
            for (index, id) in array.enumerated() {
                if let value = dictionnary[id] {
                    if index == 0 {
                        string += value
                    } else {
                        string += ", \(value)"
                    }
                }
            }
            return string
        }
        return nil
    }
}
