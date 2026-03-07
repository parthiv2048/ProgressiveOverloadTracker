//
//  Exercise.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftData
import Foundation

@Model
final class Exercise {
    var exerciseID: String
    var exerciseName: String
    var targetSets: Int?
    var targetRepRangeMin: Int?
    var targetRepRangeMax: Int?
    
    init(exerciseID: String = UUID().uuidString, exerciseName: String, targetSets: Int? = nil, targetRepRangeMin: Int? = nil, targetRepRangeMax: Int? = nil) {
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.targetSets = targetSets
        self.targetRepRangeMin = targetRepRangeMin
        self.targetRepRangeMax = targetRepRangeMax
    }
}

extension Exercise {
    static var emptyExercise = Exercise(exerciseName: "")
}
