//
//  TrackingView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 22/11/23.
//

import SwiftUI
import Charts

struct TrackingView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    @EnvironmentObject var currentTab: CurrentTab
    @State private var rawSpendingValues = [] as [Spending]
    @State private var totalSpentToday = 0.0
    @State private var currentDayIndex = 1
    @State private var barChartValues = [] as [Double]
    @State private var streak = 1
    @State private var daysViewing = 7
    @State private var totalIncome = 0.0
    @State private var totalGoals = 0.0
    @State private var budget = 0.0
    
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
    
    func calculate2() {
        totalGoals = 0.0
        totalIncome = 0.0
        
        moneyMatters.goals.forEach {
            if (Int($0.deadline.timeIntervalSince1970) >= Int(Date.now.timeIntervalSince1970)) {
                let daysToSaveUp = (Int($0.deadline.timeIntervalSince1970) - Int($0.date.timeIntervalSince1970)) / 86400
                
                totalGoals += $0.amount / Double(daysToSaveUp)
            }
        }
        
        moneyMatters.income.forEach {
            getTotalIncome(incomeRate: $0.rate, amount: $0.amount, date: $0.date)
        }
        
        budget = totalIncome - totalGoals
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Tracking").font(.custom("White Chalk", size: 75)).foregroundColor(.white).padding().padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    Image("The Cooler Plank").resizable().frame(width: 350, height: 300).shadow(radius: 5).offset(y: -10).brightness(0.2).saturation(0.75).shadow(radius: 5, x: 2.5, y: 5)
                    
                    BarChartView(data: barChartValues, colors: [Color(red: 0.335, green: 0.516, blue: 0.116), Color(red: 0.235, green: 0.416, blue: 0.016)], line: budget).frame(width: 275, height: 225).offset(y: -25)
                    
                    VStack {
                        Text("^").font(.custom("Christmas School", size: 24)).offset(y: 5)
                        
                        Text("Today").font(.custom("Christmas School", size: 12))
                    }.multilineTextAlignment(.center).offset(x: 115, y: 110)
                }.padding()
                
                Spacer()
                
                ZStack {
                    Image("The Cooler Plank").resizable().frame(width: 350, height: 75).shadow(radius: 5).brightness(0.2).saturation(0.75)
                    
                    Text("You spent $\(totalSpentToday, specifier: "%.2f") today.\nYou have a streak of \((streak == 1) ? "1 day, welcome back!" : "\(streak) days, well done.")").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center)
                }
            }.onAppear() {
                calculate()
                calculate2()
                
                func calculate() {
                    rawSpendingValues = []
                    barChartValues = []
                    streak = 1
                    
                    if (moneyMatters.spending.count > 0){
                        moneyMatters.spending.forEach {
                            rawSpendingValues.append($0)
                        }
                        
                        rawSpendingValues.sort() {
                            $0.date > $1.date
                        }
                        
                        currentDayIndex = 0
                        barChartValues.append(0.0)
                        rawSpendingValues.forEach {
                            let timeDifference = Int(Calendar.current.dateComponents([.day], from: Date.now).day ?? 0) - Int(Calendar.current.dateComponents([.day], from: $0.date).day ?? 0)
                            
                            if (timeDifference < daysViewing) {
                                if (timeDifference >= currentDayIndex) {
                                    for _ in (1...daysViewing) {
                                        if (timeDifference >= currentDayIndex) {
                                            currentDayIndex += 1
                                            barChartValues.append(0.0)
                                        }
                                    }
                                }
                                
                                barChartValues[currentDayIndex] += $0.amount
                            }
                        }
                        
                        barChartValues.remove(at: 0)
                        
                        if (daysViewing > currentDayIndex) {
                            for _ in (1...(daysViewing - currentDayIndex)) {
                                barChartValues.append(0.0)
                            }
                        }
                        
                        totalSpentToday = barChartValues[0]
                        barChartValues = barChartValues.reversed()
                        
                        currentDayIndex = 1
                        for i in (0...(moneyMatters.daysLogged.count - 1)) {
                            if (currentDayIndex != 1000000000000) {
                                if (Int(Calendar.current.dateComponents([.day], from: Date.now).day ?? 0) - Int(Calendar.current.dateComponents([.day], from: moneyMatters.daysLogged[i].date).day ?? 0) > (currentDayIndex + 1)) {
                                    currentDayIndex = 1000000000000
                                } else if (Calendar.current.isDate(moneyMatters.daysLogged[i].date, inSameDayAs: Date(timeIntervalSince1970: TimeInterval(Int(Date.now.timeIntervalSince1970) - (currentDayIndex * 86400))))) {
                                    streak += 1
                                    currentDayIndex += 1
                                }
                            }
                        }
                    }
                }
            }.frame(width: proxy.size.width)
        }
    }
}

struct TrackingViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        ZStack {
            TrackingView()
                .environmentObject(moneyMatters)
        }.onAppear() {
            moneyMatters.spending.append(Spending(name: "Amogus", amount: 46, date: Date.now))
            
            moneyMatters.spending.append(Spending(name: "Fortnite Skins", amount: 26, date: Date.now))
            
            moneyMatters.spending.append(Spending(name: "Scented Candle", amount: 54, date: Date.now - 87401))
            
            moneyMatters.spending.append(Spending(name: "Amogus", amount: 64, date: Date.now - 87401))
            
            moneyMatters.spending.append(Spending(name: "Fortnite Skins", amount: 35, date: Date.now - 172801))
            
            moneyMatters.spending.append(Spending(name: "Scented Candle", amount: 69, date: Date.now - 259201))
            
            moneyMatters.spending.append(Spending(name: "Scented Candle", amount: 69, date: Date.now - 5 * 86500))
            
            moneyMatters.spending.append(Spending(name: "Scented Candle", amount: 69, date: Date.now - 6 * 86500))
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 86500))
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 2 * 86500))
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 3 * 86500))
            
            moneyMatters.goals.append(Goal(name: "", amount: 10.0, date: Date.now, deadline: Date.now + 86400))
            
            moneyMatters.goals.append(Goal(name: "", amount: 50.0, date: Date.now, deadline: Date.now + 86400))
            
            moneyMatters.income.append(Income(name: "", amount: 100.0, date: Date.now, rate: IncomeRate.daily))
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingViewMinion()
    }
}
