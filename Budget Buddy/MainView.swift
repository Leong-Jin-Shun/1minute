//
//  MainView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 21/11/23.
//

import SwiftUI

class CurrentTab: ObservableObject {
    @Published var tab = "Home"
    @Published var updates = false
}

struct MainView: View {
    
    @EnvironmentObject var currentTab: CurrentTab
    @EnvironmentObject var moneyMatters: MoneyMatters
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                
                ZStack {
                    if (currentTab.tab == "Home") {
                        HomeScreenView().environmentObject(moneyMatters)
                    } else if (currentTab.tab == "Tracking") {
                        TrackingView().environmentObject(moneyMatters)
                    } else if (currentTab.tab == "Income") {
                        IncomeView().environmentObject(moneyMatters)
                    } else if (currentTab.tab == "Goals") {
                        GoalsView().environmentObject(moneyMatters)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    
                    ZStack {
                        HStack {
                            ZStack {
                                ScreenView().frame(width: 50, height: 50)
                                
                                if (currentTab.tab == "Home") {
                                    Image(systemName: "house.fill").scaleEffect(1.5).foregroundStyle(.green)
                                } else {
                                    Image(systemName: "house.fill").scaleEffect(1.5).foregroundStyle(Color(red: 0.335, green: 0.516, blue: 0.116))
                                }
                            }
                            
                            Spacer()
                            
                            ZStack {
                                ScreenView().frame(width: 50, height: 50)
                                
                                if (currentTab.tab == "Tracking") {
                                    Image(systemName: "antenna.radiowaves.left.and.right").scaleEffect(1.5).foregroundStyle(.green)
                                } else {
                                    Image(systemName: "antenna.radiowaves.left.and.right").scaleEffect(1.5).foregroundStyle(Color(red: 0.335, green: 0.516, blue: 0.116))
                                }
                            }
                            
                            Spacer()
                            
                            ZStack {
                                ScreenView().frame(width: 50, height: 50)
                                
                                if (currentTab.tab == "Income") {
                                    Image(systemName: "briefcase.fill").scaleEffect(1.5).foregroundStyle(.green)
                                } else {
                                    Image(systemName: "briefcase.fill").scaleEffect(1.5).foregroundStyle(Color(red: 0.335, green: 0.516, blue: 0.116))
                                }
                            }
                            
                            Spacer()
                            
                            ZStack {
                                ScreenView().frame(width: 50, height: 50)
                                
                                if (currentTab.tab == "Goals") {
                                    Image(systemName: "mappin.and.ellipse").scaleEffect(1.5).foregroundStyle(.green)
                                } else {
                                    Image(systemName: "mappin.and.ellipse").scaleEffect(1.5).foregroundStyle(Color(red: 0.335, green: 0.516, blue: 0.116))
                                }
                            }
                        }
                        
                        HStack {
                            Button {
                                withAnimation(.linear(duration: 0.1)) {
                                    currentTab.tab = "Home"
                                }
                            } label: {
                                Rectangle().opacity(0)
                            }.frame(width: 50, height: 50).contentShape(Rectangle())
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.linear(duration: 0.1)) {
                                    currentTab.tab = "Tracking"
                                }
                            } label: {
                                Rectangle().opacity(0)
                            }.frame(width: 50, height: 50).contentShape(Rectangle())
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.linear(duration: 0.1)) {
                                    currentTab.tab = "Income"
                                }
                            } label: {
                                Rectangle().opacity(0)
                            }.frame(width: 50, height: 50).contentShape(Rectangle())
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.linear(duration: 0.1)) {
                                    currentTab.tab = "Goals"
                                }
                            } label: {
                                Rectangle().opacity(0)
                            }.frame(width: 50, height: 50).contentShape(Rectangle())
                        }
                    }.padding().padding(.bottom, -5)
                    
                    Spacer()
                    Spacer()
                }
            }.frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct MainViewMinion: View {
    
    @StateObject var currentTab = CurrentTab()
    @StateObject var moneyMatters = MoneyMatters()
    
    var body: some View {
        MainView().environmentObject(currentTab)
            .environmentObject(moneyMatters)
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainViewMinion()
    }
}
