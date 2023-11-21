//
//  NewIncomeView.swift
//  Budget Buddy
//
//  Created by Sarah Chia on 20/11/23.
//

import SwiftUI

struct NewIncomeView: View {
    
    @Binding var sourceArray: [Income]
    @State var incomeTitle = ""
    @State var incomeAmount: Double = 0.0
    @State var incomeRefresh: IncomeRate = .monthly
    @State var showSaveAlert: Bool = false
    @State var showCancelAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Info") {
                TextField("Enter a source of income", text: $incomeTitle)
                TextField("Enter amount", value: $incomeAmount, format: .number)
                Picker("Payment Frequency", selection: $incomeRefresh) {
                    Text("Daily").tag(IncomeRate.daily)
                    Text("Weekly").tag(IncomeRate.weekly)
                    Text("Every other Week").tag(IncomeRate.fortnightly)
                    Text("Monthly").tag(IncomeRate.monthly)
                    Text("Every 6 Months").tag(IncomeRate.biyearly)
                }
            }
            
            Section("Actions") {
                Button("Save") {
                    if incomeTitle.count == 0 {
                        showSaveAlert = true
                    } else {
                        showSaveAlert = false
                        let newIncome = Income(title: incomeTitle, amount: incomeAmount, refresh: incomeRefresh)
                        sourceArray.append(newIncome)
                        dismiss()
                    }
                }
                .alert(isPresented: $showSaveAlert) {
                    Alert(title: Text("Enter a title"), dismissButton: .default(Text("Ok")))
                }
                Button("Cancel", role: .destructive) {
                    if incomeTitle.count == 0 {
                        dismiss()
                    }
                    showCancelAlert = true
                }
                .alert(isPresented: $showCancelAlert) {
                    Alert(title: Text("Discard income?"),
                        primaryButton: .destructive(Text("Discard")) {
                            dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewIncomeView(sourceArray: .constant([Income(title: "Testing", amount: 10.5, refresh: .daily), Income(title: "Another one", amount: 99.4, refresh: .biyearly)]))
    }
}

