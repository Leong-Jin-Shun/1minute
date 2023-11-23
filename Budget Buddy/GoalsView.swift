//
//  GoalsView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import SwiftUI

struct GoalsView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var dailyGoal = 0.0
    @State private var timeInterval = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Goals").font(.custom("Jurassic Park", size: 100)).padding().padding(.top, 50)
                
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
                
                ScrollView {
                    ForEach(0..<moneyMatters.goals.count, id: \.self) { i in
                        ZStack {
                            Image("Plank").resizable().scaledToFit()
                            
                            HStack {
                                VStack {
                                    HStack {
                                        Text("\(moneyMatters.goals[i].name)")
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Pay by \(moneyMatters.goals[i].deadline, style: .date)").opacity(0.75).font(.custom("Christmas School", size: 16))
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Text("$\(moneyMatters.goals[i].amount, specifier: "%.2f")")
                            }.font(.custom("Christmas School", size: 20)).frame(width: 300).lineSpacing(1.5)
                        }.scaleEffect(0.65).padding(-15)
                    }
                }.offset(y: -75)
                
                Spacer()
                
            }.frame(width: proxy.size.width).onAppear() {
                moneyMatters.goals.forEach {
                    if (Int(Date.now.timeIntervalSince1970) < Int($0.deadline.timeIntervalSince1970)) {
                        timeInterval = Double($0.deadline.timeIntervalSince1970) - Double(Date.now.timeIntervalSince1970)
                        
                        if (timeInterval <= 86400) {
                            dailyGoal += $0.amount
                        } else {
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
            moneyMatters.goals.append(Goal(name: "A Cool Million", amount: 1000000.00, deadline: Date.now + 365 * 86400))
            
            moneyMatters.goals.append(Goal(name: "HotWheels Car", amount: 19.65, deadline: Date.now + 86400))
        }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsViewMinion()
    }
}
