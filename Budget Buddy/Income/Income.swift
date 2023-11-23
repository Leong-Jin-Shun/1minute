//
//  Income.swift
//  Budget Buddy
//
//  Created by T Krobot on 21/11/23.
//

import Foundation

struct Income: Codable {
    var id = UUID()
    
    var name: String
    var amount: Double
    var date: Date
    var rate: IncomeRate
}

enum IncomeRate: Codable {
    case daily
    case fiveWeek //Five days a week
    case sixWeek //Six days a week
    case weekly
    case monthly
    case yearly
    case oneTime
}
