//
//  Spending.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 22/11/23.
//

import Foundation

struct Spending: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var amount: Double
    var date: Date
}
