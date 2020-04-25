//
//  ExerciseViewModel.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

struct ExerciseViewModel {
    private let id: Int
    let name: String?
    let description: String?
    let image: UIImage?
    let primaryMuscles: String?
    let secondaryMuscles: String?
    let equipment: String?
    let category: String?
    
    init(exercise: Exercise, allMuscles: [Int: String], allCategories: [Int: String], allEquipment: [Int: String]) {
        self.id = exercise.id
        if let name = exercise.name {
            self.name = "Name: \(name)"
        } else {
            self.name = nil
        }
        if let description = exercise.description {
            self.description = "Description: \(description)"
        } else {
            self.description = nil
        }
        if let categoryId = exercise.category, let category = allCategories[categoryId] {
            self.category = "Category: \(category)"
        } else {
            self.category = nil
        }
        
        let mapModelToViewModelHelper = MapModelToViewModelHelper()
        
        self.primaryMuscles = mapModelToViewModelHelper.getTextTodisplay(for: "Primary Muscles", from: exercise.muscles, using: allMuscles)
        self.secondaryMuscles = mapModelToViewModelHelper.getTextTodisplay(for: "Secondary Muscles", from: exercise.muscles_secondary, using: allMuscles)
        self.equipment = mapModelToViewModelHelper.getTextTodisplay(for: "Equipment", from: exercise.equipment, using: allEquipment)
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
