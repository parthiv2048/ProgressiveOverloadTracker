//
//  RoutineListView.swift
//  ProgressiveOverloadTracker
//
//  Created by Parthiv Ganguly on 3/6/26.
//

import SwiftUI
import SwiftData

struct RoutineListView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext
    @Query private var routineList: [Routine]
    @State private var newRoutine: Routine?
    @State private var exportURL: URL?
    @State private var showSaveConfirmation = false
    @State private var showExportError = false
    
    // MARK: - No Routines View
    
    var noRoutinesView: some View {
        Text("No Routines")
            .font(.largeTitle)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - Routines List View
    
    var routinesListView: some View {
        List {
            ForEach(routineList) { routine in
                NavigationLink(destination: EditRoutineView(routine: routine, isNewRoutine: false)) {
                    HStack {
                        Text(routine.routineName)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(routine.exercises.count) exercises")
                    }
                }
            }
            .onDelete(perform: deleteRoutines)
        }
    }
    
    // MARK: - Body View
    
    var body: some View {
        NavigationStack {
            Group {
                if routineList.isEmpty {
                    noRoutinesView
                } else {
                    routinesListView
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        saveRoutinesToFile()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(routineList.isEmpty)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let routine = Routine()
                        newRoutine = routine
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(item: $newRoutine) { routine in
                EditRoutineView(routine: routine, isNewRoutine: true)
            }
            .alert("Routines Exported", isPresented: $showSaveConfirmation) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Workout routines saved in the app's documents folder")
            }
            .alert("Save Failed", isPresented: $showExportError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Could not save workout routines. Please try again.")
            }
        }
    }
    
    // MARK: - Delete Routines Method
    
    private func deleteRoutines(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(routineList[index])
        }
    }
    
    // MARK: - Save Routines to File
    
    private func saveRoutinesToFile() {
        var output = "WORKOUT ROUTINES\n\n"
        
        for (index, routine) in routineList.enumerated() {
            output += "ROUTINE \(index + 1): \(routine.routineName)\n"
            
            if routine.exercises.isEmpty {
                output += " No exercises\n"
            } else {
                for (exIndex, exercise) in routine.exercises.enumerated() {
                    output += " \(exIndex + 1). \(exercise.exerciseName)\n"
                    
                    if let sets = exercise.targetSets {
                        output += "     Sets: \(sets)\n"
                    }
                    
                    let minReps = exercise.targetRepRangeMin.map { "\($0)" } ?? "-"
                    let maxReps = exercise.targetRepRangeMax.map { "\($0)" } ?? "-"
                    output += "     Reps: \(minReps)–\(maxReps)\n"
                }
            }
            output += "\n"
        }
        
        do {
            let fileName = "WorkoutRoutines.txt"
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            try output.write(to: fileURL, atomically: true, encoding: .utf8)
            showSaveConfirmation = true
        } catch {
            showExportError = true
        }
    }
}
