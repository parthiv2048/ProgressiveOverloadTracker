//
//  AddRoutineView.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftUI
import SwiftData

struct AddRoutineView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var newRoutine: Routine = Routine.emptyRoutine
    @State private var exercises: [Exercise] = []
    
    // MARK: - Body View
    
    var body: some View {
        Form {
            Section("Workout Name") {
                TextField("Enter workout name", text: $newRoutine.routineName)
            }
            
            Section("Exercise List") {
                List {
                    ForEach($exercises) { exercise in
                        HStack {
                            TextField("Name", text: exercise.exerciseName)
                                .layoutPriority(1)
                            TextField("Sets", value: exercise.targetSets, format: .number)
                                .frame(minWidth: 50)
                                .multilineTextAlignment(.center)
                            TextField("Min Reps", value: exercise.targetRepRangeMin, format: .number)
                                .frame(minWidth: 80)
                                .multilineTextAlignment(.center)
                            TextField("Max Reps", value: exercise.targetRepRangeMax, format: .number)
                                .frame(minWidth: 80)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                
                Button("Add Exercise") {
                    exercises.append(Exercise(exerciseName: ""))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    newRoutine.exercises = exercises
                    modelContext.insert(newRoutine)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
}
