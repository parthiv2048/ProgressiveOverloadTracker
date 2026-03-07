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
    var id: UUID
    var routineName: String
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), routineName: String = "", exercises: [Exercise] = []) {
        self.id = id
        self.routineName = routineName
        self.exercises = exercises
    }
}
