//
//  IncomeView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import SwiftUI

struct IncomeView: View {
    
    @StateObject var crud = CRUD()
    @EnvironmentObject var moneyMatters: MoneyMatters
    @EnvironmentObject var currentTab: CurrentTab
    
    @State private var totalIncome = 0.0
    
    func pullData() {
        moneyMatters.income = []
        
        if (crud.names.count != 0) {
            for i in (0...(crud.names.count - 1)) {
                moneyMatters.income.append(Income(name: crud.names[i], amount: crud.amounts[i], date: crud.dates[i], rate: crud.incomeRates[i]))
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
        
        if (moneyMatters.income.count != 0) {
            moneyMatters.income.forEach() {
                crud.names.append($0.name)
                crud.amounts.append($0.amount)
                crud.dates.append($0.date)
                crud.deadlines.append($0.date)
                crud.incomeRates.append($0.rate)
            }
        }
    }
    
    func getTotalIncome(incomeRate: IncomeRate, amount: Double, date: Date) {
        switch incomeRate {
        case .daily:
            totalIncome += amount
        case .fiveWeek:
            totalIncome += amount * 5 / 7
        case .sixWeek:
            totalIncome += amount * 6 / 7
        case .weekly:
            totalIncome += amount / 7
        case .monthly:
            totalIncome += amount / 30
        case .yearly:
            totalIncome += amount / 365
        case .oneTime:
            if (Calendar.current.isDateInToday(date)) {
                totalIncome += amount
            }
        }
    }
    
    func calculate() {
        totalIncome = 0.0
        
        moneyMatters.income.forEach {
            getTotalIncome(incomeRate: $0.rate, amount: $0.amount, date: $0.date)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Income").font(.custom("White Chalk", size: 75)).foregroundColor(.white).padding().padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    Image("The Cooler Plank").resizable().frame(width: 350, height: 75).offset(y: 10).brightness(0.2).saturation(0.75).shadow(radius: 5, x: 2.5, y: 5)
                    
                    VStack {
                        Text("You receive a daily income of around").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).offset(y: 62.5).shadow(color: .white, radius: 3.5)
                        
                        Spacer()
                        
                        Text("$\(totalIncome, specifier: "%.2f")").font(.custom("AniTypewriter", size: 50))
                        
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
                crud.target = "Income"
                pushData()
                calculate()
            }
        }
    }
}

struct IncomeViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    @StateObject var currentTab = CurrentTab()
    
    var body: some View {
        ZStack {
            IncomeView().environmentObject(moneyMatters).environmentObject(currentTab)
        }.onAppear() {
            moneyMatters.income.append(Income(name: "MacDonald's Salary", amount: 10.00, date: Date.now, rate: IncomeRate.sixWeek))
            
            moneyMatters.income.append(Income(name: "Uncle's Gift", amount: 100.00, date: Date.now, rate: IncomeRate.oneTime))
            
            moneyMatters.income.append(Income(name: "Allowance", amount: 2.00, date: Date.now, rate: IncomeRate.daily))
            
            moneyMatters.income.append(Income(name: "MacDonald's Salary", amount: 10.00, date: Date.now, rate: IncomeRate.sixWeek))
            
            moneyMatters.income.append(Income(name: "Allowance", amount: 2.00, date: Date.now, rate: IncomeRate.daily))
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeViewMinion()
    }
}
