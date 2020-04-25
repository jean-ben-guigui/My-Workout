//
//  ExerciceViewModel.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct ExerciseViewModel {
    private let id: Int
    let name: String
    let description: String?
    let image: UIImage?
    let primaryMuscles: String?
    let secondaryMuscles: String?
    let equipment: String?
    
    init(exercise: Exercise, allMuscles: [Int: String], allCategories: [Int: String], allEquipment: [Int: String]) {
        self.id = exercise.id
        self.name = exercise.name
        self.description = exercise.description
        
        let arrayHelper = ArrayHelper()
        self.primaryMuscles = arrayHelper.stringFromArray(exercise.muscles, using: allMuscles)
        self.secondaryMuscles = arrayHelper.stringFromArray(exercise.muscles_secondary, using: allMuscles)
        self.equipment = arrayHelper.stringFromArray(exercise.equipment, using: allEquipment)
        
        self.image = nil
    }
    
    
}

extension ExerciseViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ExerciseViewModel, rhs: ExerciseViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
