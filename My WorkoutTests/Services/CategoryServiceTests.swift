//
//  ExerciseCategoryServiceTests.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 27/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import My_Workout

class ExerciseCategoryServiceTests: XCTestCase {
    var categories: [ExerciseCategory]!
    var error: NetworkError!
    var categoryPage: EndpointPage<ExerciseCategory>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        categories = [ExerciseCategory(id: 1, name: "test")]
        error = NetworkError.noData
        categoryPage = EndpointPage(nextPageUrl: nil, elements: categories)
    }
    
    func testGetAll() throws {
        let mockApiHandler = MockApiHandler(successResponse: categoryPage, errorResponse: error, url: URL(string: "mockurl"))
        let categoryService = ExerciseCategoryService(apiHandler: mockApiHandler)
        
        categoryService.getAll() { [weak self] in
            guard let self = self else {
                return
            }
            switch $0 {
            case .success(let fetchedCategories):
                XCTAssertEqual(fetchedCategories, self.categories)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testGetAllNoUrl() throws {
        let mockApiHandler = MockApiHandler(successResponse: categoryPage, errorResponse: error, url: nil)
        let categoryService = ExerciseCategoryService(apiHandler: mockApiHandler)
        
        categoryService.getAll() {
            switch $0 {
            case .success(_):
                XCTFail()
            case .failure(_):
                return
            }
        }
    }
}
