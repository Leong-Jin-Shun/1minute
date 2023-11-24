//
//  Goals.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 22/11/23.
//

import Foundation

struct Goal: Codable {
    var id = UUID()
    
    var name: String
    var amount: Double
    var date: Date
    var deadline: Date
}
