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
    @Published var daysLogged = [] as [DayLog]
}

struct HomeScreenView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var budget = 0.0
    @State private var totalGoals = 0.0
    @State private var totalSpent = 0.0
    @State private var totalIncome = 0.0
    @State private var accomplishedGoals = ""
    @State private var daysToSaveUp = 0
    
    var body: some View {
        VStack {
            Text("Budget").font(.custom("Jurassic Park", size: 100)).padding().padding(.top, 50)
            
            Spacer()
            
            ZStack {
                Image("Rock Plate").resizable().scaledToFit().scaleEffect(1.45).shadow(radius: 5)
                
                VStack {
                    Text("You should spend less than").font(.custom("Christmas School", size: 18)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).offset(y: 10)
                    
                    Spacer()
                    
                    Text("$\(budget, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
                    
                    Spacer()
                }
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
                if (Int($0.deadline.timeIntervalSince1970) >= Int(Date.now.timeIntervalSince1970)) {
                    daysToSaveUp = (Int($0.deadline.timeIntervalSince1970) - Int(Date.now.timeIntervalSince1970)) / 86400
                    totalGoals += $0.amount / Double(daysToSaveUp)
                }
            }
            
            moneyMatters.spending.forEach {
                if (Int(Date.now.timeIntervalSince1970) - Int($0.date.timeIntervalSince1970) <= 86400) {
                    totalSpent += $0.amount
                }
            }
            
            moneyMatters.income.forEach {
                totalIncome += $0.amount
            }
            
            budget = totalIncome - totalGoals
            
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
        ZStack {
            HomeScreenView().environmentObject(moneyMatters)
        }.onAppear() {
            moneyMatters.goals.append(Goal(name: "A Life", amount: 1000000, deadline: Date.now + 30 * 86400))
            
            moneyMatters.goals.append(Goal(name: "HotWheels Car", amount: 19.65, deadline: Date.now + 86400))
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenViewMinion()
    }
}
