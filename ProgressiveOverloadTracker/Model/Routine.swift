//
//  Routine.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftData
import Foundation

@Model
final class Routine {
    var routineID: String
    var routineName: String
    var exercises: [Exercise]
    
    init(routineID: String = UUID().uuidString, routineName: String, exercises: [Exercise]) {
        self.routineID = routineID
        self.routineName = routineName
        self.exercises = exercises
    }
}

extension Routine {
    static var emptyRoutine = Routine(routineName: "", exercises: [])
}
