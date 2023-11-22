////
////  PurchasesView.swift
////  Budget Buddy
////
////  Created by Christian Kaden Lim on 20/11/23.
////
//
//import SwiftUI
//import Forever
//
//struct PurchasesView: View {
//    @Forever("purchases") var purchases: [Purchase] = []
//
//    @State private var showSampleAlert: Bool = false
//    @State private var showNewPurchaseSheet: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HStack {
//                    Text("$\(purchases.reduce(0) { $0 + $1.amount }, specifier: "%.2f")")
//                }
//                List($purchases, editActions: .all) { $purchase in
//                    NavigationLink {
//                        PurchaseDetailView(purchase: $purchase)
//                    } label: {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(purchase.name)
//                                HStack {
//                                    Text("$\(purchase.amount, specifier: "%.2f")")
//                                        .font(.caption)
//                                        .foregroundStyle(.gray)
//                                    Spacer()
//                                    Text("On \(purchase.pretty_date())")
//                                        .font(.caption)
//                                        .foregroundStyle(.gray)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("My Spending")
//            .toolbar {
//                ToolbarItemGroup {
//
//                    #if DEBUG
//
//                    Button {
//                        showSampleAlert = true
//                    } label: {
//                        Label("Load sample data", systemImage: "clipboard")
//                    }
//
//                    #endif
//
//                    Button {
//                        showNewPurchaseSheet = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//            }
//            .sheet(isPresented: $showNewPurchaseSheet, content: {
//                NewPurchaseView(purchases: $purchases)
//                    .presentationDetents([.medium, .large])
//            })
//            .alert(isPresented: $showSampleAlert) {
//                Alert(title: Text("Load sample data?"),
//                      primaryButton: .destructive(Text("Load")) {
//                    purchases = Purchase.sample_purchases
//                },
//                      secondaryButton: .cancel(Text("Cancel"))
//                )
//            }
//        }
//    }
//}
//
//struct PurchasesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchasesView()
//    }
//}
