////
////  NavigationView.swift
////  Budget Buddy
////
////  Created by Christian Kaden Lim on 20/11/23.
////
//
//import SwiftUI
//
//struct MainTabView: View {
//    var body: some View {
//            TabView {
//                HomeScreenView()
//                    .environmentObject(MoneyMatters())
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//
//                PurchasesView()
//                    .tabItem {
//                        Label("Tracking", systemImage: "circle")
//                    }
//                GoalsView()
//                    .tabItem{
//                        Label("Goals", systemImage: "circle")
//                    }
//                IncomeView()
//                    .tabItem{
//                        Label("Income", systemImage: "circle")
//                    }
//            }
//    }
//}
//
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//
//    }
//}
