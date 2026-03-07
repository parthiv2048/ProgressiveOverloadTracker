//
//  Exercise.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftData

@Model
final class Exercise {
    var exerciseID: String
    var exerciseName: String
    var targetSets: Int
    var targetRepRangeMin: Int
    var targetRepRangeMax: Int
    
    init(exerciseID: String, exerciseName: String, targetSets: Int, targetRepRangeMin: Int, targetRepRangeMax: Int) {
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.targetSets = targetSets
        self.targetRepRangeMin = targetRepRangeMin
        self.targetRepRangeMax = targetRepRangeMax
    }
}
