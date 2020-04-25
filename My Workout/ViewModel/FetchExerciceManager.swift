//
//  fetchHandler.swift
//  My Workout
//
//  Created by Arthur Duver on 24/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

class FetchExerciseManager {
    private var muscles = [Int: String]()
    private var equipment = [Int: String]()
    private var categories = [Int: String]()
    private var exerciseImage = [Int: [URL]]()
    private var exercises = Set<Exercise>()
    private var exercisesViewModel = Set<ExerciseViewModel>()
    private var error: NetworkError?
    private let apiHandler = ApiHandler()
    
    func loadData(completionHandler: @escaping (Set<ExerciseViewModel>) -> Void ) {
        let fetchGroup = DispatchGroup()
        
        fetchCategories(dispatchGroup: fetchGroup)
        fetchMuscles(dispatchGroup: fetchGroup)
        fetchExercises(dispatchGroup: fetchGroup)
        fetchEquipment(dispatchGroup: fetchGroup)
//        fetchImagesLink(dispatchGroup: fetchGroup)
        
        fetchGroup.wait()
        
        var exercisesViewModelArray = [ExerciseViewModel]()
        for exercise in exercises {
            let exerciseViewModel = ExerciseViewModel(
                exercise: exercise,
                allMuscles: muscles,
                allCategories: categories,
                allEquipment: equipment
            )
            exercisesViewModelArray.append(exerciseViewModel)
        }
        exercisesViewModel = Set<ExerciseViewModel>(exercisesViewModelArray)
        
        let downloadGroup = DispatchGroup()
        
        downloadImages(dispatchGroup: downloadGroup)
        
        downloadGroup.wait()
        
        completionHandler(exercisesViewModel)
    }
    
    func downloadImages(dispatchGroup: DispatchGroup) {
        let imageService = ExerciseImageService(apiHandler: apiHandler, parseHandler: ParseHandler<ExerciseImage>())
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
    
    func fetchExercises(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        let exerciseService = ExerciseService(
            apiHandler: apiHandler
        )
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

//    func fetchImagesLink(dispatchGroup: DispatchGroup) {
//        dispatchGroup.enter()
//
//        let exerciseImageService = ExerciseImageService(
//            apiHandler: apiHandler,
//            parseHandler: ParseHandler<ExerciseImage>()
//        )
//
//        exerciseImageService.getImages(for bien: Set<Exercise>)
//            { [weak self] (exerciseImageResult) in
//            guard let self = self else {
//                return
//            }
//            switch exerciseImageResult {
//            case .success(let fetchedExerciseImage):
//                for exerciseImage in fetchedExerciseImage {
//                    self.exerciseImage[exerciseImage.id] = exerciseImage.name
//                }
//            case .failure(let error):
//                self.error = error
//            }
//            dispatchGroup.leave()
//        }
//    }
    
    //TODO if there is some time left: generalize the fetchEndpointDictionnary
//    func fetchEndpointDictionnary<Endpoint: WgerAPIEndpoint>(dispatchGroup: DispatchGroup) {
//        dispatchGroup.enter()
//
//    }
    
    private func addExercises(exercises: [Exercise]) {
        self.exercises.union(exercises)
    }
}
