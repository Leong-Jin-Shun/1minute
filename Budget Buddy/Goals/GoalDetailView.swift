//
//  GoalDetailView.swift
//  Budget Buddy
//
//  Created by T Krobot on 20/11/23.
//

import SwiftUI

struct GoalDetailView: View {
    @Binding var goal: Goal
    
    var body: some View {
        Form {
            TextField("Enter your goal", text: $goal.name)
            TextField("Enter your goal amount", value: $goal.amount, formatter: NumberFormatter())
            DatePicker("Deadline", selection: $goal.deadline, in: Date.now..., displayedComponents: .date)
            Toggle("High Priority", isOn: $goal.isPriority)
                .toggleStyle(.switch)
        }
        .navigationTitle("Goal Details")
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal:
                .constant(Goal(name: "Buy new Iphone 15 Pro Max Ultra 5G", amount: 151515, deadline: Date(timeInterval: 604800, since: Date.now), isPriority: false)
            )
        )
    }
}
