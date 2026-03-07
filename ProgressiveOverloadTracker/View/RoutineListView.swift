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
                Text(routine.routineName)
            }
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
                    NavigationLink(destination: AddRoutineView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
