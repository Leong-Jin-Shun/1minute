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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Info") {
                TextField("Title", text: $incomeTitle)
                TextField("Amount", value: $incomeAmount, format: .number)
            }
            
            Section("Actions") {
                Button("Save") {
                    let newIncome = Income(title: incomeTitle, amount: incomeAmount)
                    sourceArray.append(newIncome)
                    dismiss()
                }
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewIncomeView(sourceArray: .constant([Income(title: "Testing", amount: 10.5), Income(title: "Another one", amount: 99.4)]))
    }
}

