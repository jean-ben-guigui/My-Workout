//
//  ParseHandlerTests.swift
//  My WorkoutTests
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import XCTest
@testable import My_Workout

class ParseHandlerTests: XCTestCase {

    func testParseData() throws {
        let parseHandler = ParseHandler<Equipment>()
        let jsonString = """
            {
                "id": 1,
                "name": "Barbell"
            }
        """
        if let json = jsonString.data(using: .utf8) {
            parseHandler.parseData(json) {
                switch $0 {
                case .success(let equipment):
                    XCTAssertEqual(equipment, Equipment(id: 1, name: "Barbell"))
                case .failure(_):
                    XCTFail()
                }
            }
        } else {
            XCTFail()
        }
    }
    
    func testParseDataFails() throws {
        let parseHandler = ParseHandler<Equipment>()
        let jsonString = """
            {
                "noid": 1,
                "noname": "Barbell"
            }
        """
        let json = jsonString.data(using: .utf8)!
        parseHandler.parseData(json) {
            switch $0 {
            case .success(_):
                XCTFail()
            case .failure(_):
                return
            }
        }
    }

}
