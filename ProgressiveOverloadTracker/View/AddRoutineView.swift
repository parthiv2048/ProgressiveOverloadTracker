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
    @State private var newRoutine: Routine = Routine.emptyRoutine
    
    var body: some View {
        Form {
            Section("Workout Name") {
                TextField("Enter workout name", text: $newRoutine.routineName)
            }
        }
    }
}

#Preview {
    AddRoutineView()
}
