//
//  NetworkError.swift
//  My Workout
//
//  Created by Arthur Duver on 22/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case JSONDecoding(_ error: Error?)
    case urlInit
    case noData
}
