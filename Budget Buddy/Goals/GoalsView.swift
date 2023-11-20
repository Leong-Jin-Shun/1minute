//
//  GoalsView.swift
//  Budget Buddy
//
//  Created by T Krobot on 20/11/23.
//

import SwiftUI
import Forever

struct GoalsView: View {
    @Forever("goals") var goals: [Goal] = []
    @State private var showSampleAlert: Bool = false
    @State private var showNewGoalSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List($goals, editActions: .all) { $goal in
                NavigationLink {
                    GoalDetailView(goal: $goal)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(goal.name)
                            HStack {
                                Text("$\(String(goal.amount))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("By \(goal.pretty_date())")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Goals")
            .toolbar {
                ToolbarItemGroup {
                    
                    #if DEBUG
                    
                    Button {
                        showSampleAlert = true
                    } label: {
                        Label("Load sample data", systemImage: "clipboard")
                    }
                    
                    #endif
                    
                    Button {
                        showNewGoalSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showNewGoalSheet, content: {
                NewGoalView(goals: $goals)
                    .presentationDetents([.medium, .large])
            })
            .alert(isPresented: $showSampleAlert) {
                Alert(title: Text("Load sample data?"),
                      primaryButton: .destructive(Text("Load")) {
                    goals = Goal.sampleGoals
                },
                      secondaryButton: .cancel(Text("Cancel"))
                )
            }
        }
    }
}
    

        
struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
