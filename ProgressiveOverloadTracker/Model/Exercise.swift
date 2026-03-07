//
//  Exercise.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftData
import Foundation

struct Exercise: Codable, Identifiable {
    var id = UUID()
    var exerciseName: String = ""
    var targetSets: Int?
    var targetRepRangeMin: Int?
    var targetRepRangeMax: Int?
}
