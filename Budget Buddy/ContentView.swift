//
//  ContentView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI
import Forever

class PersistentVars: Codable {
    var goals = [] as [Goal]
    var income = [] as [Income]
    var spending = [] as [Spending]
    var daysLogged = [] as [DayLog]
}

struct ContentView: View {
    
    @Forever("PersistentVars") var persistentVars = PersistentVars()
    
    @StateObject var leafVar = LeafVar()
    @StateObject var moneyMatters = MoneyMatters()
    @StateObject var currentTab = CurrentTab()
    @State private var titleVar = 0.0
    @State private var transparency = 0.0
    
    var body: some View {
        ZStack {
            BackgroundView().environmentObject(leafVar)
            
            if (transparency != 1.0) {
                Image("Rock Plate").resizable().scaledToFit().offset(y: CGFloat(-187.5 * titleVar)).scaleEffect(1.0 - 0.09 * titleVar).shadow(radius: 5)
                
                TitleView().offset(y: CGFloat(-187.5 * titleVar)).scaleEffect(1.0 - 0.1 * titleVar).opacity(1.0 - titleVar)
            }
            
            ZStack {
                NavigationView().environmentObject(moneyMatters).environmentObject(currentTab).padding()
            }.opacity(transparency)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Image("Sky").resizable().scaledToFill()).ignoresSafeArea().onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.interpolatingSpring(stiffness: 225, damping: 15)) {
                    leafVar.rotation = 1.0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) {
                withAnimation() {
                    titleVar = 1.0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation() {
                    transparency = 1.0
                }
            }
            
            persistentVars.daysLogged.append(DayLog(date: Date.now))
            moneyMatters.goals = persistentVars.goals
            moneyMatters.income = persistentVars.income
            moneyMatters.spending = persistentVars.spending
            moneyMatters.daysLogged = persistentVars.daysLogged
            
            moneyMatters.spending.append(Spending(name: "Amogus", amount: 10.95, date: Date.now))
            
            moneyMatters.spending.append(Spending(name: "Fortnite Skins", amount: 120.25, date: Date.now))
            
            moneyMatters.spending.append(Spending(name: "Scented Candle", amount: 8.00, date: Date.now))
            
            moneyMatters.income.append(Income(name: "MacDonald's Salary", amount: 10.00, rate: IncomeRate.sixWeek))
            
            moneyMatters.income.append(Income(name: "Allowance", amount: 2.00, rate: IncomeRate.daily))
            
            moneyMatters.goals.append(Goal(name: "A Cool Million", amount: 1000000.00, deadline: Date.now + 365 * 86400))
            
            moneyMatters.goals.append(Goal(name: "HotWheels Car", amount: 19.65, deadline: Date.now + 86400))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
