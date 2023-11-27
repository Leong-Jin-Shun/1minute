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
    
    func update() {
        persistentVars.goals = moneyMatters.goals
        persistentVars.income = moneyMatters.income
        persistentVars.spending = moneyMatters.spending
    }
    
    var body: some View {
        ZStack {
            BackgroundView().environmentObject(leafVar)
            
            if (transparency != 1.0) {
                //Image("Rock Plate").resizable().scaledToFit().offset(y: CGFloat(-185 * titleVar)).scaleEffect(1.0 - 0.125 * titleVar).shadow(radius: 5)
                
                TitleView().scaleEffect(1.0 - 0.5 * titleVar).offset(y: CGFloat(-600 * titleVar))
            }
            
            ZStack {
                MainView().environmentObject(moneyMatters).environmentObject(currentTab).padding().onChange(of: currentTab.updates) { _ in
                    currentTab.updates = false
                    update()
                }
            }.opacity(transparency)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().onAppear() {
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
            
            if (persistentVars.daysLogged.count == 0) {
                requestAuth()
            }
            
            persistentVars.daysLogged.append(DayLog(date: Date.now))
            moneyMatters.goals = persistentVars.goals
            moneyMatters.income = persistentVars.income
            moneyMatters.spending = persistentVars.spending
            moneyMatters.daysLogged = persistentVars.daysLogged
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
