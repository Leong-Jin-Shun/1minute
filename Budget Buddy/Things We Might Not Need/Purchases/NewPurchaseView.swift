////
////  NewPurchaseView.swift
////  Budget Buddy
////
////  Created by T Krobot on 21/11/23.
////
//
//import SwiftUI
//
//struct NewPurchaseView: View {
//    @Binding var purchases: [Purchase]
//    @State private var purchaseName: String = ""
//    @State private var purchaseAmount: Float = 0
//    @State private var purchaseDate: Date = Date.now
//    @State private var showCancelAlert = false
//    @State private var showSaveAlert = false
//    @State private var discard = true
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        Form() {
//            Section("Info") {
//                TextField("Enter your purchase", text: $purchaseName)
//                TextField("Enter your purchase amount", value: $purchaseAmount, formatter: NumberFormatter())
//                DatePicker("Date of purchase", selection: $purchaseDate, in: Date.now..., displayedComponents: .date)
//            }
//
//            Section("Actions") {
//                Button("Save") {
//                    if purchaseName.count == 0 {
//                        showSaveAlert = true
//                    } else {
//                        showSaveAlert = false
//                        let newPurchase = Purchase(name: purchaseName, amount: purchaseAmount, date: purchaseDate)
//                        purchases.append(newPurchase)
//                        purchases.sort(by: {
//                            return !($0.date <= $1.date)
//                        })
//                        dismiss()
//                    }
//                }
//                .alert(isPresented: $showSaveAlert) {
//                    Alert(title: Text("Enter a purchase"), dismissButton: .default(Text("Ok")))
//                }
//                Button("Cancel", role: .destructive) {
//                    if purchaseName.count == 0 {
//                        dismiss()
//                    }
//                    showCancelAlert = true
//                }
//                .alert(isPresented: $showCancelAlert) {
//                    Alert(title: Text("Discard purchase?"),
//                        primaryButton: .destructive(Text("Discard")) {
//                            dismiss()
//                        },
//                        secondaryButton: .cancel()
//                    )
//                }
//            }
//        }
//    }
//}
//
//struct NewPurchaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPurchaseView(purchases:
//                .constant(Purchase.sample_purchases))
//    }
//}
