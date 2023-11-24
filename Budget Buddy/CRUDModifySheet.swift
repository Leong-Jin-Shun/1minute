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
    @State var isOneTimeIncome: Bool
    @Binding var performCRUD: Bool
    
    var body: some View {
        NavigationView() {
            Form {
                VStack {
                    TextField("Provide a description", text: $name)
                    
                    TextField("Amount of money", value: $amount, format: .currency(code: locale.currency?.identifier ?? "USD"))
                    
                    if (type != "Income" || isOneTimeIncome == true) {
                        DatePicker(type == "Goal" ? "Deadline:" : "Date:", selection: $date, in: Date.now..., displayedComponents: .date)
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
    
    @State private var type = "Goal"
    @State private var name = "Adolf Hitler"
    @State private var amount = 6.90
    @State private var date = Date.now
    @State private var yes = true
    
    var body: some View {
        VStack {
            Text(name)
            Text(name)
            Text("$\(amount, specifier: "%.2f")")
            Text(date, style: .date)
        }.sheet(isPresented: $yes) {
            CRUDModifySheet(type: type, name: $name, amount: $amount, date: $date, isOneTimeIncome: false, performCRUD: $yes)
        }
    }
}

struct CRUDModifySheet_Previews: PreviewProvider {
    static var previews: some View {
        CRUDModifySheetMinion()
    }
}
