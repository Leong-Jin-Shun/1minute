//
//  IncomeView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI

struct IncomeView: View {
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    @State private var income = 0.0
    
    var body: some View {
        VStack {
            Spacer()
                
            Text("Total Income").font(.custom("Jurassic", size: 36))
            
            ZStack {
                Image("Rock Plate").resizable().scaledToFit().scaleEffect(0.9).shadow(radius: 5)
                
                Text("$\(income, specifier: "%.2f")").font(.custom("JungleFever", size: 36))
            }.padding()
            
            Spacer()
            
            ScrollView {
                ForEach(0..<moneyMatters.income.count, id: \.self) { i in
                    ZStack {
                        Image("Plank").resizable().scaledToFit()
                        
                        Text("You collected $\(moneyMatters.income[i], specifier: "%.2f"), well done")
                    }.scaleEffect(0.75).padding(-15)
                }
            }
            
            Spacer()
            
            NavigationView().padding()
        }.onAppear() {
            for i in moneyMatters.income {
                income += moneyMatters.income[Int(i)]
            }
        }
    }
}

struct IncomeViewMinion: View {
    
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        IncomeView().environmentObject(moneyMatters)
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeViewMinion()
    }
}
