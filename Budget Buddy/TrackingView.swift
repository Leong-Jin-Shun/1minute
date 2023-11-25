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
    @State private var daysViewed = 7
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Tracking").font(.custom("White Chalk", size: 75)).foregroundColor(.white).padding().padding(.top, 50)
                
                Spacer()
                
                ZStack {
                    Image("Rock Plate").resizable().frame(width: 350, height: 400).rotationEffect(.degrees(-90)).shadow(radius: 5).opacity(0)
                    
                    BarChartView(data: barChartValues, colors: [Color(red: 0.335, green: 0.516, blue: 0.116), Color(red: 0.235, green: 0.416, blue: 0.016)]).frame(width: 275, height: 225).offset(y: -25)
                    
                    VStack {
                        Text("^").font(.custom("Christmas School", size: 24)).offset(y: 5)
                        
                        Text("Today").font(.custom("Christmas School", size: 12))
                    }.multilineTextAlignment(.center).offset(x: 115, y: 110)
                }.padding().shadow(color: .white, radius: 5)
                
                Spacer()
                
                ZStack {
                    Image("Plank").resizable().scaledToFit().padding().opacity(0)
                    
                    Text("You spent $\(totalSpentToday, specifier: "%.2f") today.\nYou have a streak of \((streak == 1) ? "1 day, welcome back!" : "\(streak) days, well done.")").font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5).multilineTextAlignment(.center).shadow(color: .white, radius: 3.5)
                }
            }.onAppear() {
                calculate()
                
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
                            if (Int(Date.now.timeIntervalSince1970) - Int($0.date.timeIntervalSince1970) <= daysViewed * 86400) {
                                if (Int(Date.now.timeIntervalSince1970) - Int($0.date.timeIntervalSince1970) >= currentDayIndex * 86400) {
                                    currentDayIndex += 1
                                    barChartValues.append(0.0)
                                }
                                
                                barChartValues[currentDayIndex] += $0.amount
                            }
                        }
                        
                        barChartValues.remove(at: 0)
                        
                        for _ in (1...(daysViewed - currentDayIndex)) {
                            barChartValues.append(0.0)
                        }
                        
                        totalSpentToday = barChartValues[0]
                        barChartValues = barChartValues.reversed()
                        
                        currentDayIndex = 1
                        for i in (0...(moneyMatters.daysLogged.count - 1)) {
                            if (currentDayIndex != 1000000000000) {
                                if (Int(Date.now.timeIntervalSince1970) - Int(moneyMatters.daysLogged[i].date.timeIntervalSince1970) > (currentDayIndex + 1) *  86400) {
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
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 86500))
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 2 * 86500))
            
            moneyMatters.daysLogged.append(DayLog(date: Date.now - 3 * 86500))
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingViewMinion()
    }
}
