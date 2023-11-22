//
//  HomeScreenView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

class MoneyMatters: ObservableObject {
    @Published var goals = [] as [Goal]
    @Published var income = [] as [Income]
    @Published var spending = [] as [Spending]
}

struct HomeScreenView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var totalGoals = 0.0
    @State private var totalSpent = 0.0
    @State private var totalIncome = 0.0
    @State private var accomplishedGoals = ""
    
    var body: some View {
        VStack {
            
            Text("Budget").font(.custom("Jurassic Park", size: 100)).padding().padding(.top, 50)
            
            Spacer()
            
            ZStack {
                Image("Rock Plate").resizable().scaledToFit().scaleEffect(1.45).shadow(radius: 5)
                
                Text("$\(totalGoals, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
            }.padding()
            
            ZStack {
                Image("Plank").resizable().scaledToFit().padding()
                
                Text("You have spent a total of $\(totalSpent, specifier: "%.2f") today. You can \(accomplishedGoals)buy the items you have planned for.").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center)
            }
            
            Spacer()
            
            ScrollView {
                ForEach(0..<moneyMatters.spending.count, id: \.self) { i in
                    ZStack {
                        Image("Plank").resizable().scaledToFit()

                        HStack {
                            VStack {
                                HStack {
                                    Text("\(moneyMatters.spending[i].name)")
                                    
                                    Spacer()
                                }
                                
                                Text("\(moneyMatters.spending[i].date)").opacity(0.75).font(.custom("Christmas School", size: 16))
                            }
                            
                            Spacer()
                            
                            Text("$\(moneyMatters.spending[i].amount, specifier: "%.2f")")
                        }.font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5)
                    }.scaleEffect(0.65).padding(-15)
                }
            }
            
            ZStack {
                Image("Plank").resizable().scaledToFit().padding()
                
                Text("You have received a total of $\(totalIncome, specifier: "%.2f") from your collective income today.").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center)
            }
            
            Spacer()
            
        }.onAppear() {
            moneyMatters.goals.forEach {
                totalGoals += $0.amount
            }
            
            moneyMatters.spending.forEach {
                totalSpent += $0.amount
            }
            
            moneyMatters.income.forEach {
                totalIncome += $0.amount
            }
            
            if (totalIncome - totalSpent < totalGoals) {
                accomplishedGoals = "not "
            }
            
            if (totalIncome - totalSpent == totalGoals) {
                accomplishedGoals = "barely "
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
