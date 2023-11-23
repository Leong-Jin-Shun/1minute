//
//  IncomeView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import SwiftUI

struct IncomeView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var totalIncome = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Income").font(.custom("Jurassic Park", size: 100)).padding().padding(.top, 50)
                
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
                
                ScrollView {
                    ForEach(0..<moneyMatters.income.count, id: \.self) { i in
                        ZStack {
                            Image("Plank").resizable().scaledToFit()
                            
                            HStack {
                                VStack {
                                    HStack {
                                        Text("\(moneyMatters.income[i].name)")
                                        
                                        Spacer()
                                    }
                                    
                                    if (moneyMatters.income[i].rate == .oneTime) {
                                        HStack {
                                            Text("\(moneyMatters.income[i].date, style: .date)").opacity(0.75).font(.custom("Christmas School", size: 16))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Text("$\(moneyMatters.income[i].amount, specifier: "%.2f")")
                            }.font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5)
                        }.scaleEffect(0.65).padding(-15)
                    }
                }.offset(y: -75)
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
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
                
                moneyMatters.income.forEach {
                    getTotalIncome(incomeRate: $0.rate, amount: $0.amount, date: $0.date)
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
