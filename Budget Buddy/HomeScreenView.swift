//
//  HomeScreenView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

class MoneyMatters: ObservableObject {
    @Published var goals = [] as [Double]
    @Published var income = [] as [Double]
    @Published var spending = [] as [Double]
}

struct HomeScreenView: View {
    
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var budget = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("Rock Plate").resizable().scaledToFit().scaleEffect(0.9).shadow(radius: 5)
                
                Text("$\(budget, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
            }.padding()
            
            Image("Plank").resizable().scaledToFit().padding()
            
            Spacer()
            
            ScrollView {
                ForEach(0..<moneyMatters.spending.count, id: \.self) { i in
                    ZStack {
                        Image("Plank").resizable().scaledToFit()
                        
                        Text("You spent $\(moneyMatters.spending[i], specifier: "%.2f"), you pig")
                    }.scaleEffect(0.75).padding(-15)
                }
            }
            
            Spacer()
            
        }.onAppear() {
            for i in moneyMatters.goals {
                budget += moneyMatters.goals[Int(i)]
            }
        }
    }
}

struct HomeScreenViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        HomeScreenView().environmentObject(moneyMatters)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenViewMinion()
    }
}
