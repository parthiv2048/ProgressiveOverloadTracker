//
//  AddRoutineView.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftUI
import SwiftData

struct EditRoutineView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var routine: Routine
    
    // MARK: - Body View
    
    var body: some View {
        Form {
            Section("Workout Name") {
                TextField("Enter workout name", text: $routine.routineName)
                    .textInputAutocapitalization(.words)
            }
            
            Section("Exercise List") {
                List {
                    ForEach($routine.exercises) { exercise in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Name")
                                    .fontWeight(.semibold)
                                TextField("Name", text: exercise.exerciseName)
                                    .textInputAutocapitalization(.words)
                            }
                            .layoutPriority(1)
                            VStack(alignment: .leading) {
                                Text("Sets")
                                    .fontWeight(.semibold)
                                TextField("Sets", value: exercise.targetSets, format: .number)
                                    .keyboardType(.numberPad)
                            }
                            .frame(minWidth: 50)
                            VStack(alignment: .leading) {
                                Text("Reps")
                                    .fontWeight(.semibold)
                                HStack {
                                    TextField("Min", value: exercise.targetRepRangeMin, format: .number)
                                        .keyboardType(.numberPad)
                                    TextField("Max", value: exercise.targetRepRangeMax, format: .number)
                                        .keyboardType(.numberPad)
                                }
                            }
                            .frame(minWidth: 110)
                        }
                    }
                    .onDelete(perform: deleteExercises)
                }
                
                Button("Add Exercise") {
                    routine.exercises.append(Exercise())
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    try? modelContext.save()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
    
    // MARK: - Delete Exercises Method
    
    private func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            routine.exercises.remove(at: index)
        }
    }
}
