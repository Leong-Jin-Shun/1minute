//
//  NewGoalView.swift
//  Budget Buddy
//
//  Created by T Krobot on 20/11/23.
//

import SwiftUI

struct NewGoalView: View {
    @Binding var goals: [Goal]
    @State private var goalName: String = ""
    @State private var goalAmount: Int = 0
    @State private var goalDeadline: Date = Date.now
    @State private var showCancelAlert = false
    @State private var showSaveAlert = false
    @State private var discard = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form() {
            Section("Info") {
                TextField("Enter your goal", text: $goalName)
                TextField("Enter your goal amount", value: $goalAmount, formatter: NumberFormatter())
                DatePicker("Choose when the deadline is", selection: $goalDeadline, in: Date.now..., displayedComponents: .date)
            }
            
            Section("Actions") {
                Button("Save") {
                    if goalName.count == 0 {
                        showSaveAlert = true
                    } else {
                        showSaveAlert = false
                        let newGoal = Goal(name: goalName, amount: goalAmount, deadline: goalDeadline)
                        goals.append(newGoal)
                        dismiss()
                    }
                }
                Button("Cancel", role: .destructive) {
                    if goalName.count > 0 {
                        discard = false
                        showCancelAlert = true
                    }
                    if discard {
                        showCancelAlert = false
                        dismiss()
                    }
                }
            }
        }
        .alert(isPresented: $showCancelAlert) {
            Alert(title: Text("Discard todo?"),
                primaryButton: .destructive(Text("Discard")) {
                    discard = true
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $showSaveAlert) {
            Alert(title: Text("Enter a title"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(goals:
                .constant(Goal.sampleGoals))
    }
}
