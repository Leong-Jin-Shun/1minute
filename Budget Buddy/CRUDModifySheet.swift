//
//  CRUDModifySheet.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 24/11/23.
//

import SwiftUI

struct CRUDModifySheet: View {
    
    @Environment(\.locale) private var locale
    
    @State var type: String
    @Binding var name: String
    @Binding var amount: Double
    @Binding var date: Date
    @Binding var deadline: Date
    @Binding var incomeRate: IncomeRate
    @Binding var performCRUD: Bool
    
    var body: some View {
        NavigationView() {
            Form {
                VStack {
                    TextField("Provide a description", text: $name)
                    
                    TextField("Amount of money", value: $amount, format: .currency(code: locale.currency?.identifier ?? "USD")) .textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                    if (type == "Spending") {
                        DatePicker("Date:", selection: $date, in: ...Date.now, displayedComponents: .date)
                            .toggleStyle(.switch)
                    } else if (type == "Income") {
                        if (incomeRate == IncomeRate.oneTime) {
                            DatePicker("Date:", selection: $date, displayedComponents: .date)
                                .toggleStyle(.switch)
                        }
                        
                        Picker("Select an income rate:", selection: $incomeRate) {
                            Text("Daily").tag(IncomeRate.daily)
                            Text("Five days a week").tag(IncomeRate.fiveWeek)
                            Text("Six days a week").tag(IncomeRate.sixWeek)
                            Text("Weekly").tag(IncomeRate.weekly)
                            Text("Monthly").tag(IncomeRate.monthly)
                            Text("Yearly").tag(IncomeRate.yearly)
                            Text("One time payment").tag(IncomeRate.oneTime)
                        }
                    } else if (type == "Goals") {
                        DatePicker("Deadline:", selection: $deadline, displayedComponents: .date)
                            .toggleStyle(.switch)
                    }
                    
                    Button("Done") {
                        performCRUD = false
                    }.buttonStyle(.borderedProminent)
                }
            }
            .navigationBarTitle("Modify This \(type)")
        }
    }
}

struct CRUDModifySheetMinion: View {
    
    @State private var type = "Income"
    @State private var name = "Adolf Hitler"
    @State private var amount = 6.90
    @State private var date = Date.now
    @State private var deadline = Date.now
    @State private var incomeRate = IncomeRate.oneTime
    @State private var yes = true
    
    var body: some View {
        VStack {
            Text(type)
            Text(name)
            Text("$\(amount, specifier: "%.2f")")
            Text(date, style: .date)
        }.sheet(isPresented: $yes) {
            CRUDModifySheet(type: type, name: $name, amount: $amount, date: $date, deadline: $deadline, incomeRate: $incomeRate, performCRUD: $yes)
        }
    }
}

struct CRUDModifySheet_Previews: PreviewProvider {
    static var previews: some View {
        CRUDModifySheetMinion()
    }
}
