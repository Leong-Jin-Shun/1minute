//
//  CRUDPanelsView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import SwiftUI

class CRUD: ObservableObject, Equatable {
    @Published var target = "Goal"
    @Published var names = [] as [String]
    @Published var amounts = [] as [Double]
    @Published var dates = [] as [Date]
    @Published var deadlines = [] as [Date]
    @Published var incomeRates = [] as [IncomeRate]
    @Published var needsUpdate = false
    
    static func ==(lhs: CRUD, rhs: CRUD) -> Bool {
        return lhs.names == rhs.names && lhs.amounts == rhs.amounts && lhs.dates == rhs.dates
    }
}

struct CRUDPanelsView: View {
    
    @EnvironmentObject var crud: CRUD
    @State private var selectedPanel: Int?
    @State private var performCRUD = false
    @State private var buttonOpacity = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(.white).frame(width: 30).shadow(radius: 5)
                
                Image(systemName: "plus.circle.fill").scaleEffect(2).foregroundColor(Color(red: 0.235, green: 0.416, blue: 0.016))
                
                Circle().frame(width: 50).opacity(buttonOpacity).contentShape(Circle()).onTapGesture() {
                    crud.names.insert("", at: 0)
                    crud.amounts.insert(10, at: 0)
                    crud.dates.insert(Date.now, at: 0)
                    crud.deadlines.insert(Date.now, at: 0)
                    crud.incomeRates.insert(IncomeRate.oneTime, at: 0)
                    selectedPanel = 0
                    performCRUD = true
                }
            }.padding(0)
            
            ScrollView {
                ForEach(0..<crud.names.count, id: \.self) { i in
                    ZStack {
                        Image("The Cooler Plank").resizable().scaleEffect(x: 1, y: 0.75).brightness(0.2).saturation(0.75).shadow(radius: 5, x: 2.5, y: 5)

                        Rectangle().opacity(0).contentShape(Rectangle()).onTapGesture() {
                            if (!performCRUD) {
                                if (selectedPanel == i) {
                                    selectedPanel = nil
                                } else {
                                    selectedPanel = i
                                }
                            }
                        }

                        HStack {
                            VStack {
                                HStack {
                                    Text("\(crud.names[i])")
                                    
                                    Spacer()
                                }
                                
                                
                                HStack {
                                    if (crud.target == "Goal") {
                                        Text("Pay by \(crud.deadlines[i], style: .date)")
                                    } else {
                                        Text("\(crud.dates[i], style: .date)")
                                    }
                                    
                                    Spacer()
                                }.opacity(0.75).font(.custom("Christmas School", size: 18))
                            }
                            
                            Spacer()
                            
                            Text("$\(crud.amounts[i], specifier: "%.2f")").opacity(selectedPanel == i ? 0 : 1)
                        }.font(.custom("Christmas School", size: 24)).frame(width: 375).lineSpacing(1.5)

                        if (selectedPanel == i) {
                            HStack {
                                Spacer()

                                ZStack {
                                    Image(systemName: "square.and.pencil").scaleEffect(2)

                                    Rectangle().frame(width: 35, height: 35).opacity(buttonOpacity).contentShape(Rectangle()).onTapGesture() {
                                        performCRUD = true
                                    }
                                }

                                ZStack {
                                    Image(systemName: "trash.fill").scaleEffect(2)

                                    Rectangle().frame(width: 35, height: 35).opacity(buttonOpacity).contentShape(Rectangle()).onTapGesture() {
                                        crud.names.remove(at: i)
                                        crud.amounts.remove(at: i)
                                        crud.dates.remove(at: i)
                                        crud.needsUpdate = true
                                    }
                                }
                            }.offset(x: 1.5).padding(30)
                        }

                        ZStack {
                            Image(systemName: "chevron.up")

                            Rectangle().frame(width: 35, height: 35).opacity(buttonOpacity).contentShape(Rectangle()).onTapGesture() {
                                if (i != 0) {
                                    crud.names.swapAt(i, i - 1)
                                    crud.amounts.swapAt(i, i - 1)
                                    crud.dates.swapAt(i, i - 1)
                                    selectedPanel = nil
                                    crud.needsUpdate = true
                                }
                            }
                        }.offset(x: 180, y: -35)

                        ZStack {
                            Image(systemName: "chevron.down")

                            Rectangle().frame(width: 35, height: 35).opacity(buttonOpacity).contentShape(Rectangle()).onTapGesture() {
                                if (i != crud.names.count - 1) {
                                    crud.names.swapAt(i, i + 1)
                                    crud.amounts.swapAt(i, i + 1)
                                    crud.dates.swapAt(i, i + 1)
                                    selectedPanel = nil
                                    crud.needsUpdate = true
                                }
                            }
                        }.offset(x: 180, y: 35)
                    }.scaleEffect(0.65).padding(-30)
                }
            }
        }.sheet(isPresented: $performCRUD) {
            if (selectedPanel != nil) {
                CRUDModifySheet(type: crud.target, name: $crud.names[selectedPanel!], amount: $crud.amounts[selectedPanel!], date: $crud.dates[selectedPanel!], deadline: $crud.deadlines[selectedPanel!], incomeRate: $crud.incomeRates[selectedPanel!], performCRUD: $performCRUD)
                
            }
        }.onChange(of: performCRUD) { _ in
            crud.needsUpdate = true
        }
    }
}

struct CRUDPanelsViewMinion: View {
    
    @StateObject var crud = CRUD()
    
    var body: some View {
        CRUDPanelsView().environmentObject(crud).onAppear() {
            crud.names.append("Amogus")
            crud.names.append("FNaF")
            crud.names.append("Fortnite")
            crud.amounts.append(12.50)
            crud.amounts.append(10.00)
            crud.amounts.append(11.95)
            crud.dates.append(Date.now)
            crud.dates.append(Date.now)
            crud.dates.append(Date.now)
            crud.deadlines.append(Date.now)
            crud.deadlines.append(Date.now)
            crud.deadlines.append(Date.now)
            crud.target = "Spending"
        }
    }
}

struct CRUDPanelsView_Previews: PreviewProvider {
    static var previews: some View {
        CRUDPanelsViewMinion()
    }
}
