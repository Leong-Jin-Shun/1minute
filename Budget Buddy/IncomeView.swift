//
//  IncomeView.swift
//  Budget Buddy
//
//  Created by Sarah Chia on 20/11/23.
//

import SwiftUI

struct Income: Identifiable {
    
    var id = UUID()
    var title: String
    var amount: Double
}

struct IncomeView: View {
    
    @State private var incomes = [
        Income(title: "ihsgfd", amount: 23.40),
        Income(title: "asdf", amount: 12.32),
        Income(title: "ef", amount: 34.09)
    ]
    @State private var showNewIncomeSheet: Bool =  false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("$\(incomes.reduce(0) { $0 + $1.amount }, specifier: "%.2f")")
                }
                
                List($incomes, editActions: .all) { $income in
                    NavigationLink {
                        IncomeDetailView(income: $income)
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(income.title)")
                            HStack {
                                Text("$\(String(income.amount))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Income")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewIncomeSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showNewIncomeSheet) {
            NewIncomeView(sourceArray: $incomes)
                .presentationDetents([.medium, .large])
        }
    }
}
    //        .onAppear {
    //            for i in incomes {
    //                totalIncome += Double(i)
    //            }
    //        }
    
struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
