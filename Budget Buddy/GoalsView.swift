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
            crud.names.forEach() { i in
                moneyMatters.goals.append(Goal(name: crud.names[Int(i)!], amount: crud.amounts[Int(i)!], date: crud.dates[Int(i)!], deadline: crud.deadlines[Int(i)!]))
            }
        }
        
        currentTab.updates = true
    }
    
    func pushData() {
        crud.names = []
        crud.amounts = []
        crud.dates = []
        crud.deadlines = []
        
        if (moneyMatters.goals.count != 0) {
            moneyMatters.goals.forEach() {
                crud.names.append($0.name)
                crud.amounts.append($0.amount)
                crud.dates.append($0.date)
                crud.deadlines.append($0.deadline)
            }
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Goals").font(.custom("White Chalk", size: 100)).foregroundColor(.white).padding().padding(.top, 40)
                
                Spacer()
                
                ZStack {
                    Image("Rock Plate").resizable().scaledToFit().scaleEffect(1.09).shadow(radius: 5)
                    
                    VStack {
                        Text("Every day, you should save up").font(.custom("Christmas School", size: 18)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).offset(y: 80)
                        
                        Spacer()
                        
                        Text("$\(dailyGoal, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
                        
                        Spacer()
                    }
                }.padding().offset(y: -62.5)
                
                Spacer()
                
                CRUDPanelsView().environmentObject(crud).padding(.bottom, -75).offset(y: -75).onChange(of: crud) { _ in
                    pullData()
                }
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
                crud.target = "Goal"
                pushData()
                calculate()
                
                func calculate() {
                    dailyGoal = 0.0
                    
                    moneyMatters.goals.forEach {
                        if (Int(Date.now.timeIntervalSince1970) < Int($0.deadline.timeIntervalSince1970)) {
                            timeInterval = Double($0.deadline.timeIntervalSince1970) - Double($0.date.timeIntervalSince1970)
                            
                            dailyGoal += $0.amount * 86400 / timeInterval
                        }
                    }
                }
            }
        }
    }
}

struct GoalsViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        ZStack {
            GoalsView().environmentObject(moneyMatters)
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
