//
//  GoalsView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import SwiftUI

struct GoalsView: View {
    
    @StateObject var crud = CRUD()
    @EnvironmentObject var moneyMatters: MoneyMatters
    @EnvironmentObject var currentTab: CurrentTab
    
    @State private var dailyGoal = 0.0
    @State private var timeInterval = 0.0
    
    func pullData() {
        moneyMatters.goals = []
        
        if (crud.names.count != 0) {
            for i in (0...(crud.names.count - 1)) {
                moneyMatters.goals.append(Goal(name: crud.names[i], amount: crud.amounts[i], date: crud.dates[i], deadline: crud.deadlines[i]))
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
        
        if (moneyMatters.goals.count != 0) {
            moneyMatters.goals.forEach() {
                crud.names.append($0.name)
                crud.amounts.append($0.amount)
                crud.dates.append($0.date)
                crud.deadlines.append($0.deadline)
                crud.incomeRates.append(IncomeRate.oneTime)
            }
        }
    }
    
    func calculate() {
        dailyGoal = 0.0
        
        moneyMatters.goals.forEach {
            if (Int(Date.now.timeIntervalSince1970) < Int($0.deadline.timeIntervalSince1970)) {
                timeInterval = Double($0.deadline.timeIntervalSince1970) - Double($0.date.timeIntervalSince1970)
                
                dailyGoal += $0.amount * 86400 / timeInterval
            }
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Goals").font(.custom("White Chalk", size: 75)).foregroundColor(.white).padding().padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    Image("The Cooler Plank").resizable().frame(width: 350, height: 75).offset(y: 10).brightness(0.2).saturation(0.75).shadow(radius: 5, x: 2.5, y: 5)
                    
                    VStack {
                        Text("Every day, you should save up").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).offset(y: 62.5).shadow(color: .white, radius: 3.5)
                        
                        Spacer()
                        
                        Text("$\(dailyGoal, specifier: "%.2f")").font(.custom("AniTypewriter", size: 50))
                        
                        Spacer()
                    }
                }.padding().offset(y: -62.5)
                
                Spacer()
                
                CRUDPanelsView().environmentObject(crud).padding(.bottom, -150).offset(y: -150).onChange(of: crud.needsUpdate) { _ in
                    if (crud.needsUpdate) {
                        crud.needsUpdate = false
                        pullData()
                        calculate()
                    }
                }
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
                crud.target = "Goal"
                pushData()
                calculate()
            }
        }
    }
}

struct GoalsViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    @StateObject var currentTab = CurrentTab()
    
    var body: some View {
        ZStack {
            GoalsView().environmentObject(moneyMatters).environmentObject(currentTab)
        }.onAppear() {
            moneyMatters.goals.append(Goal(name: "A Cool Million", amount: 1000000.00, date: Date.now, deadline: Date.now + 365 * 86400))
            
            moneyMatters.goals.append(Goal(name: "HotWheels Car", amount: 19.65, date: Date.now, deadline: Date.now + 86400))
        }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsViewMinion()
    }
}
