//
//  HomeScreenView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

class MoneyMatters: ObservableObject {
    @Published var goals = [] as [Double]
    @Published var income = [] as [Double]
    @Published var spending = [] as [Double]
}

struct HomeScreenView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var budget = 0.0
    @State private var totalSpent = 0.0
    @State private var totalIncome = 0.0
    @State private var exceededBudget = ""
    
    var body: some View {
        VStack {
            
            Text("Budget").font(.custom("Jurassic Park", size: 100)).padding().padding(.top, 50)
            
            Spacer()
            
            ZStack {
                Image("Rock Plate").resizable().scaledToFit().scaleEffect(1.45).shadow(radius: 5)
                
                Text("$\(budget, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
            }.padding()
            
            ZStack {
                Image("Plank").resizable().scaledToFit().padding()
                
                Text("You have spent a total of $\(totalSpent, specifier: "%.2f") today. You have \(exceededBudget)exceeded your budget.").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center)
            }
            
            Spacer()
            
            ScrollView {
                ForEach(0..<moneyMatters.spending.count, id: \.self) { i in
                    ZStack {
                        Image("Plank").resizable().scaledToFit()

                        Text("You spent $\(moneyMatters.spending[i], specifier: "%.2f"), you pig")
                    }.scaleEffect(0.75).padding(-15)
                }
            }
            
            ZStack {
                Image("Plank").resizable().scaledToFit().padding()
                
                Text("You have received a total of $\(totalIncome, specifier: "%.2f") from your collective income today.").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center)
            }
            
            Spacer()
            
        }.onAppear() {
            moneyMatters.goals.forEach {
                budget += $0
            }
            
            moneyMatters.spending.forEach {
                totalSpent += $0
            }
            
            moneyMatters.income.forEach {
                totalSpent -= $0
                totalIncome += $0
            }
            
            if (totalSpent <= budget) {
                exceededBudget = "not "
            }
        }
    }
}

struct HomeScreenViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        HomeScreenView().environmentObject(moneyMatters)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenViewMinion()
    }
}
