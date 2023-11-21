//
//  Income.swift
//  Budget Buddy
//
//  Created by T Krobot on 21/11/23.
//

import Foundation

struct Income: Codable, Identifiable {
    var id = UUID()
    
    var title: String
    var amount: Double
    var refresh: IncomeRate
}

enum IncomeRate: Codable {
    case daily
    case weekly
    case fortnightly
    case monthly
    case biyearly
    case yearly
}
