//
//  fetchHandler.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

/// Fetches ExerciseViewModel for the view controllers
class FetchExerciseViewModelManager {
    private var initialized = false
    private var muscles = [Int: String]()
    private var equipment = [Int: String]()
    private var categories = [Int: String]()
    private var exerciseImage = [Int: [URL]]()
    private var exercises = Set<Exercise>()
    private var exercisesViewModel = Set<ExerciseViewModel>()
    private var error: NetworkError?
    private let apiHandler = ApiHandler()
    let exerciseService: ExerciseService
    
    init(exerciseService: ExerciseService = ExerciseService()) {
        self.exerciseService = exerciseService
    }
    
    /// Download all the data to be displayed in the view controllers
    func loadData(completionHandler: @escaping (Set<ExerciseViewModel>) -> Void) {
        let fetchGroup = DispatchGroup()
        
        if !initialized {
            initialized = true
            fetchCategories(dispatchGroup: fetchGroup)
            fetchMuscles(dispatchGroup: fetchGroup)
            fetchEquipment(dispatchGroup: fetchGroup)
        }
        
        fetchExercises(dispatchGroup: fetchGroup)
        fetchGroup.wait()
        
        let map = MapModelToViewModelHelper()
        exercisesViewModel = map.getViewModelFrom(exercises, allMuscles: muscles, allCategories: categories, allEquipment: equipment)
        
        let downloadGroup = DispatchGroup()
        downloadImages(dispatchGroup: downloadGroup)
        downloadGroup.wait()
        
        completionHandler(exercisesViewModel)
    }
    
    //MARK: - Images
    
    /// Download Images for the current set of Exercices
    private func downloadImages(
        dispatchGroup: DispatchGroup
    ) {
        let imageService = ExerciseImageService(apiHandler: apiHandler)
        for exercise in exercises {
            dispatchGroup.enter()
            imageService.getRandomImage(for: exercise) { [weak self] (uiImageResult) in
                guard let self = self else {
                    return
                }
                switch uiImageResult {
                case .success(let uiImage):
                    if var exerciseViewModel = self.exercisesViewModel.first(where: { $0.id == exercise.id } ) {
                        exerciseViewModel.image = uiImage
                        self.exercisesViewModel.update(with: exerciseViewModel)
                        dispatchGroup.leave()
                    } else {
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    self.error = error
                    dispatchGroup.leave()
                }
            }
        }
    }
    
    //MARK: - Categories

    /// Fetch the exercise categories and add them to the category dictionnary
    private func fetchCategories(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        let categoryService = ExerciseCategoryService(apiHandler: apiHandler)
        
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
    
    //MARK: - Exercises
    
    /// Fetch the next page of exercises and add them to the exercise Set dictionnary
    private func fetchExercises(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        exerciseService.getNextExercises() { [weak self] (exercisesResult) in
            guard let self = self else {
                return
            }
            switch exercisesResult {
            case .success(let fetchedExercises):
                self.exercises = Set(fetchedExercises)
            case .failure(let error):
                self.error = error
            }
            dispatchGroup.leave()
        }
    }
    
    //MARK: - Muscles
    
    /// Fetch the muscles and add them to the muscle dictionnary
    private func fetchMuscles(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        let muscleService = MuscleService(apiHandler: apiHandler)
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
    
    //MARK: - Equipment
    
    /// Fetch the equipment and add it to the equipment dictionnary
    private func fetchEquipment(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        
        let equipmentService = EquipmentService(apiHandler: apiHandler)
        
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
}
