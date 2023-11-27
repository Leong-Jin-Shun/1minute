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
    
    @StateObject var crud = CRUD()
    @EnvironmentObject var moneyMatters: MoneyMatters
    @EnvironmentObject var currentTab: CurrentTab
    
    @State private var budget = 0.0
    @State private var totalGoals = 0.0
    @State private var totalSpent = 0.0
    @State private var totalIncome = 0.0
    @State private var accomplishedGoals = ""
    @State private var daysToSaveUp = 0
    
    func pullData() {
        moneyMatters.spending = []
        
        if (crud.names.count != 0) {
            for i in (0...(crud.names.count - 1)) {
                moneyMatters.spending.append(Spending(name: crud.names[i], amount: crud.amounts[i], date: crud.dates[i]))
            }
        }
        
        currentTab.updates = true
    }
    
    func pushData() {
        crud.names = []
        crud.amounts = []
        crud.dates = []
        crud.deadlines = []
        crud.incomeRates = []
        
        if (moneyMatters.spending.count != 0) {
            moneyMatters.spending.forEach() {
                crud.names.append($0.name)
                crud.amounts.append($0.amount)
                crud.dates.append($0.date)
                crud.deadlines.append($0.date)
                crud.incomeRates.append(IncomeRate.oneTime)
            }
        }
    }
    
    func calculate() {
        totalGoals = 0.0
        totalIncome = 0.0
        totalSpent = 0.0
        
        moneyMatters.goals.forEach {
            if (Int($0.deadline.timeIntervalSince1970) >= Int(Date.now.timeIntervalSince1970)) {
                daysToSaveUp = (Int($0.deadline.timeIntervalSince1970) - Int($0.date.timeIntervalSince1970)) / 86400
                
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
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Budget").font(.custom("White Chalk", size: 75)).foregroundColor(.white).padding().padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    Image("The Cooler Plank").resizable().frame(width: 350, height: 75).offset(y: -21.5).brightness(0.2).saturation(0.75).shadow(radius: 5, x: 2.5, y: 5)
                    
                    VStack {
                        Text("You should spend less than").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).shadow(color: .white, radius: 3.5).offset(y: 1)
                        
                        Spacer()
                        
                        Text("$\(budget, specifier: "%.2f")").font(.custom("AniTypewriter", size: 50)).offset(y: -31.5)
                        
                        Spacer()
                    }
                }.padding()
                
                ZStack {
                    Image("Plank").resizable().scaledToFit().padding().opacity(0)
                    
                    Text("You have spent a total of $\(totalSpent, specifier: "%.2f")  and received a collective income of $\(totalIncome, specifier: "%.2f") today. You can \(accomplishedGoals)buy the items you have planned for eventually.").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).shadow(color: .white, radius: 3.5).padding()
                }.offset(y: -100)
                
                Spacer()
                
                CRUDPanelsView().environmentObject(crud).padding(-15).offset(y: -100).padding(.bottom, -100).onChange(of: crud.needsUpdate) { _ in
                    if (crud.needsUpdate) {
                        crud.needsUpdate = false
                        pullData()
                        calculate()
                    }
                }
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
                crud.target = "Spending"
                pushData()
                calculate()
            }
        }
    }
}

struct HomeScreenViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    @StateObject var currentTab = CurrentTab()
    
    var body: some View {
        ZStack {
            HomeScreenView().environmentObject(moneyMatters).environmentObject(currentTab)
        }.onAppear() {
            moneyMatters.goals.append(Goal(name: "A Life", amount: 1000000, date: Date.now, deadline: Date.now + 30 * 86400))
            
            moneyMatters.goals.append(Goal(name: "HotWheels Car", amount: 19.65, date: Date.now, deadline: Date.now + 86400))
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenViewMinion()
    }
}
