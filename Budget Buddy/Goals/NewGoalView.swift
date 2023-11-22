////
////  NewGoalView.swift
////  Budget Buddy
////
////  Created by T Krobot on 20/11/23.
////
//
//import SwiftUI
//
//struct NewGoalView: View {
//    @Binding var goals: [Goal]
//    @State private var goalName: String = ""
//    @State private var goalAmount: Float = 0
//    @State private var goalDeadline: Date = Date.now
//    @State private var goalPriority: Bool = false
//    @State private var showCancelAlert = false
//    @State private var showSaveAlert = false
//    @State private var discard = true
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        Form() {
//            Section("Info") {
//                TextField("Enter your goal", text: $goalName)
//                TextField("Enter your goal amount", value: $goalAmount, formatter: NumberFormatter())
//                DatePicker("Deadline", selection: $goalDeadline, in: Date.now..., displayedComponents: .date)
//                Toggle("High Priority", isOn: $goalPriority)
//                    .toggleStyle(.switch)
//            }
//            
//            Section("Actions") {
//                Button("Save") {
//                    if goalName.count == 0 {
//                        showSaveAlert = true
//                    } else {
//                        showSaveAlert = false
//                        let newGoal = Goal(name: goalName, amount: goalAmount, deadline: goalDeadline, isPriority: goalPriority)
//                        goals.append(newGoal)
//                        goals.sort(by: {
//                            return ($0.deadline <= $1.deadline)
//                        })
//                        dismiss()
//                    }
//                }
//                .alert(isPresented: $showSaveAlert) {
//                    Alert(title: Text("Enter a purchase"), dismissButton: .default(Text("Ok")))
//                }
//                Button("Cancel", role: .destructive) {
//                    if goalName.count == 0 {
//                        dismiss()
//                    }
//                    showCancelAlert = true
//                }
//                .alert(isPresented: $showCancelAlert) {
//                    Alert(title: Text("Discard goal?"),
//                        primaryButton: .destructive(Text("Discard")) {
//                            dismiss()
//                        },
//                        secondaryButton: .cancel()
//                    )
//                }
//            }
//        }
//    }
//}
//
//struct NewGoalView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoalView(goals:
//                .constant(Goal.sampleGoals))
//    }
//}
