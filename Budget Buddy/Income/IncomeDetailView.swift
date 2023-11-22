////
////  IncomeDetailView.swift
////  Budget Buddy
////
////  Created by Sarah Chia on 20/11/23.
////
//
//import SwiftUI
//
//struct IncomeDetailView: View {
//    
//    @Binding var income: Income
//    
//    var body: some View {
//        Form {
//            TextField("Enter source of income", text: $income.title)
//            TextField("Enter amount", value: $income.amount, format: .number)
//        }
//        .navigationTitle("Income Details")
//    }
//}
//
//
//struct IncomeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomeDetailView(income: .constant(Income(title: "Testing", amount: 10.5, refresh: .daily)))
//    }
//}
//
