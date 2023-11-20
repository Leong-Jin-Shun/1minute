//
//  Goal.swift
//  Budget Buddy
//
//  Created by T Krobot on 20/11/23.
//

import Foundation

struct Goal: Codable, Identifiable {
    var id = UUID()
    
    var name: String
    var amount: Int
    var deadline: Date
    
    func pretty_date() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        return dateFormatter.string(from: self.deadline)
    }
}
