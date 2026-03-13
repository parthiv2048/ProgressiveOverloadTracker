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
    let isNewRoutine: Bool
    
    // MARK: - Workout Form
    
    var workoutForm: some View {
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
                                InputLabel(text: "Name")
                                TextField("Name", text: exercise.exerciseName)
                                    .textInputAutocapitalization(.words)
                            }
                            .layoutPriority(1)
                            
                            VStack(alignment: .leading) {
                                InputLabel(text: "Sets")
                                NumberInputField(placeholder: "Sets", value: exercise.targetSets)
                            }
                            .frame(minWidth: 50)
                            
                            VStack(alignment: .leading) {
                                InputLabel(text: "Reps")
                                HStack {
                                    NumberInputField(placeholder: "Min", value: exercise.targetRepRangeMin)
                                    NumberInputField(placeholder: "Max", value: exercise.targetRepRangeMax)
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
                    if isNewRoutine {
                        modelContext.insert(routine)
                    }
                    try? modelContext.save()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
    
    // MARK: - Body View
    
    var body: some View {
        workoutForm
    }
    
    // MARK: - Delete Exercises Method
    
    private func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            routine.exercises.remove(at: index)
        }
    }
}

// MARK: - Label for Input Textfields

private struct InputLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
    }
}

// MARK: - Textfield for Numerical Inputs

private struct NumberInputField: View {
    let placeholder: String
    let value: Binding<Int?>
    
    var body: some View {
        TextField(placeholder, value: value, format: .number)
            .keyboardType(.numberPad)
    }
}
