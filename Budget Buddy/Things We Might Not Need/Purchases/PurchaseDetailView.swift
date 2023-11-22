////
////  PurchaseDetailView.swift
////  Budget Buddy
////
////  Created by T Krobot on 21/11/23.
////
//
//import SwiftUI
//
//struct PurchaseDetailView: View {
//    @Binding var purchase: Purchase
//
//    var body: some View {
//        Form {
//            TextField("Enter your purchase", text: $purchase.name)
//            TextField("Enter your purchase amount", value: $purchase.amount, formatter: NumberFormatter())
//            DatePicker("Date of purchase", selection: $purchase.date, in: Date.now..., displayedComponents: .date)
//        }
//        .navigationTitle("Purchase Details")
//    }
//}
//
//struct PurchaseDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchaseDetailView(purchase:
//                .constant(Purchase(name: "Finally bought the new Iphone 15 pro max ultra 5G", amount: 15151515, date: Date(timeInterval: 604800, since: Date.now)))
//        )
//    }
//}
