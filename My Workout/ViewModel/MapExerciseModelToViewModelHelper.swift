//
//  exerciseDescriptionHelper.swift
//  My Workout
//
//  Created by Arthur Duver on 25/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// A helper to create ExerciseViewModels
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
    
    /// Create a set of ExerciseViewModel from a set of Exercise
    func getViewModelFrom(_ exercises: Set<Exercise>, allMuscles: [Int: String], allCategories: [Int: String], allEquipment: [Int: String]) -> Set<ExerciseViewModel> {
        var exercisesViewModelArray = [ExerciseViewModel]()
        for exercise in exercises {
            let exerciseViewModel = ExerciseViewModel(
                exercise: exercise,
                allMuscles: allMuscles,
                allCategories: allCategories,
                allEquipment: allEquipment
            )
            exercisesViewModelArray.append(exerciseViewModel)
        }
        return Set(exercisesViewModelArray)
    }
}
