//
//  NewGoalView.swift
//  Budget Buddy
//
//  Created by T Krobot on 20/11/23.
//

import SwiftUI

struct GoalDetailsView: View {
    @Binding var goal: Goal
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GoalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailsView(goal:
                .constant(Goal(name: "Buy new Iphone 15 Pro Max Ultra 5G", amount: 151515, deadline: Date(timeInterval: 604800, since: Date.now))
            )
        )
    }
}
