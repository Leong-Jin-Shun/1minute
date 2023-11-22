//
//  ContentView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 18/11/23.
//

import SwiftUI

struct ContentView: View {
    
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
            
            for _ in 1...10 {
                moneyMatters.spending.append(420.69)
                moneyMatters.goals.append(420.0)
                moneyMatters.income.append(69.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
