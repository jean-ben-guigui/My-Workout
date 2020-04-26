//
//  ApiHandlerTests.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import My_Workout

class ApiHandlerTests: XCTestCase {

    func testCreateRequest() throws {
        let apiHandler = ApiHandler()
        let request = apiHandler.createRequest(host: "host", path: "/path/", defaultQueries: true, queries: ["key": "value"])
        XCTAssertEqual(request?.absoluteString, "https://host/path/?status=2&language=2&key=value")
    }
    
    func testCreateNilRequest() throws {
        let apiHandler = ApiHandler()
        let request = apiHandler.createRequest(host: "host", path: "path/", defaultQueries: false, queries: ["key": "value"])
        XCTAssertEqual(request?.absoluteString, nil)
    }
}
