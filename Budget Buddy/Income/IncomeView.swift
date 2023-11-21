//
//  IncomeView.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 20/11/23.
//

import SwiftUI
import Forever

struct IncomeView: View {
    
    @Forever("incomes") var incomes: [Income] = []
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
                                Text("$\(income.amount, specifier: "%.2f")")
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
    
struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
