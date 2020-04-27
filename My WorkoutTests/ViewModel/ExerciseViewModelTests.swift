//
//  ExerciseViewModelTest.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import My_Workout


class ExerciseViewModelTests: XCTestCase {
    private var muscles = [Int: String]()
    private var equipment = [Int: String]()
    private var categories = [Int: String]()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        muscles = [1: "biceps", 2: "triceps"]
        categories = [1: "abs"]
        equipment = [1: "bench"]
    }

    func testInit() throws {
        let exercise = Exercise(id: 1, name: "testExercise", description: "testDescription", category: 1, equipment: [1], muscles: [1, 2], muscles_secondary: [2])
        let exerciseViewModel = ExerciseViewModel(exercise: exercise, allMuscles: muscles, allCategories: categories, allEquipment: equipment)
        XCTAssertEqual(exerciseViewModel.id, 1)
        XCTAssertEqual(exerciseViewModel.name, "testExercise")
        XCTAssertEqual(exerciseViewModel.category, "Category: abs")
        XCTAssertEqual(exerciseViewModel.equipment, "Equipment: bench")
        XCTAssertEqual(exerciseViewModel.description, "Description: testDescription")
        XCTAssertEqual(exerciseViewModel.image, nil)
        XCTAssertEqual(exerciseViewModel.primaryMuscles, "Primary Muscles: biceps, triceps")
        XCTAssertEqual(exerciseViewModel.secondaryMuscles, "Secondary Muscles: triceps")
    }
    
    func testEquals() throws {
        let exercise1 = Exercise(id: 1, name: "testExercise", description: "testDescription", category: 1, equipment: nil, muscles: nil, muscles_secondary: nil)
        let exercise2 = Exercise(id: 1, name: "testExercise2", description: "testDescription2", category: 2, equipment: nil, muscles: nil, muscles_secondary: nil)
        let exerciseViewModel1 = ExerciseViewModel(exercise: exercise1, allMuscles: muscles, allCategories: categories, allEquipment: equipment)
        let exerciseViewModel2 = ExerciseViewModel(exercise: exercise2, allMuscles: muscles, allCategories: categories, allEquipment: equipment)
        XCTAssertEqual(exerciseViewModel1, exerciseViewModel2)
    }

}
