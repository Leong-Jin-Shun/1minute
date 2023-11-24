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
            crud.names.forEach() { i in
                moneyMatters.income.append(Income(name: crud.names[Int(i)!], amount: crud.amounts[Int(i)!], date: crud.dates[Int(i)!], rate: crud.incomeRates[Int(i)!]))
            }
        }
        
        currentTab.updates = true
    }
    
    func pushData() {
        crud.names = []
        crud.amounts = []
        crud.incomeRates = []
        
        if (moneyMatters.income.count != 0) {
            moneyMatters.income.forEach() {
                crud.names.append($0.name)
                crud.amounts.append($0.amount)
                crud.incomeRates.append($0.rate)
            }
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Income").font(.custom("White Chalk", size: 100)).foregroundColor(.white).padding().padding(.top, 40)
                
                Spacer()
                
                ZStack {
                    Image("Rock Plate").resizable().scaledToFit().scaleEffect(1.09).shadow(radius: 5)
                    
                    VStack {
                        Text("You receive a daily income of around").font(.custom("Christmas School", size: 18)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).offset(y: 80)
                        
                        Spacer()
                        
                        Text("$\(totalIncome, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
                        
                        Spacer()
                    }
                }.padding().offset(y: -62.5)
                
                Spacer()
                
                CRUDPanelsView().environmentObject(crud).padding(.bottom, -75).offset(y: -75).onChange(of: crud) { _ in
                    pullData()
                }
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
                crud.target = "Income"
                pushData()
                calculate()
                
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
            }
        }
    }
}

struct IncomeViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        ZStack {
            IncomeView().environmentObject(moneyMatters)
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
