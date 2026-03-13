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
        }
    }
    
    // MARK: - Delete Routines Method
    
    private func deleteRoutines(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(routineList[index])
        }
    }
}
