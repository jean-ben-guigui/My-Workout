//
//  fetchHandler.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

class FetchHandler {
    private var muscles = [Int: String]()
    private var equipment = [Int: String]()
    private var categories = [Int: String]()
    private var exercises: Set<Exercise> = Set<Exercise>()
    private var error: NetworkError?
    private let apiHandler = ApiHandler()
    
    //TODO make this method throw and handle it in the viewcontroller
    func loadData(completionHandler: @escaping ((Result<[ExerciseViewModel], NetworkError>) -> Void) ) {
        let fetchGroup = DispatchGroup()
        
        fetchCategories(dispatchGroup: fetchGroup)
        fetchMuscles(dispatchGroup: fetchGroup)
        fetchExercises(dispatchGroup: fetchGroup)
        fetchEquipment(dispatchGroup: fetchGroup)
        
        fetchGroup.wait()
        
        var exercisesViewModel = [ExerciseViewModel]()
        
        for exercise in exercises {
            let exerciseViewModel = ExerciseViewModel(
                exercise: exercise,
                allMuscles: muscles,
                allCategories: categories,
                allEquipment: equipment
            )
            exercisesViewModel.append(exerciseViewModel)
        }
        
        
        completionHandler(.success(exercisesViewModel))
    }

    //TODO make this method throw and handle it in the viewcontroller
    func fetchCategories(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        let categoryService = CategoryService(
            apiHandler: apiHandler,
            parseHandler: ParseHandler<EndpointPage<Category>>()
        )
        
        categoryService.getAll() { [weak self] (categoriesResult) in
            guard let self = self else {
                return
            }
            switch categoriesResult {
            case .success(let fetchedCategories):
                for category in fetchedCategories {
                    self.categories[category.id] = category.name
                }
            case .failure(let error):
                self.error = error
            }
            dispatchGroup.leave()
        }
    }
    
    //TODO make this method throw and handle it in the viewcontroller
    func fetchExercises(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        let exerciseService = ExerciseService(
            apiHandler: apiHandler
        )
        exerciseService.getNextExercises() { [weak self] (exercicesResult) in
            guard let self = self else {
                return
            }
            switch exercicesResult {
            case .success(let fetchedExercises):
                self.exercises = Set(fetchedExercises)
            case .failure(let error):
                self.error = error
            }
            dispatchGroup.leave()
        }
    }
    
    //TODO make this method throw and handle it in the viewcontroller
    func fetchMuscles(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        let muscleService = MuscleService(
            apiHandler: apiHandler,
            parseHandler: ParseHandler<Muscle>()
        )
        muscleService.getAll() { [weak self] (musclesResult) in
            guard let self = self else {
                return
            }
            switch musclesResult {
            case .success(let fetchedMuscles):
                for muscle in fetchedMuscles {
                    self.muscles[muscle.id] = muscle.name
                }
            case .failure(let error):
                self.error = error
            }
            dispatchGroup.leave()
        }
    }
    
    //TODO make this method throw and handle it in the viewcontroller
    func fetchEquipment(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        let equipmentService = EquipmentService(
            apiHandler: apiHandler,
            parseHandler: ParseHandler<Equipment>()
        )
        
        equipmentService.getAll() { [weak self] (equipmentResult) in
            guard let self = self else {
                return
            }
            switch equipmentResult {
            case .success(let fetchedEquipment):
                for equipment in fetchedEquipment {
                    self.equipment[equipment.id] = equipment.name
                }
            case .failure(let error):
                self.error = error
            }
            dispatchGroup.leave()
        }
    }
    
    private func addExercises(exercices: [Exercise]) {
        self.exercises.union(exercises)
    }
        
}
