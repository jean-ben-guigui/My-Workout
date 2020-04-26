//
//  MapModelToCiewModelHelperTests.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import My_Workout

class MapModelToCiewModelHelperTests: XCTestCase {

    func testGetTextTodisplay() throws {
        let map = MapModelToViewModelHelper()
        let text = map.getTextTodisplay(for: "test", from: [1, 2], using: [1: "1", 2: "2"])
        XCTAssertEqual(text, "test: 1, 2")
    }
}
