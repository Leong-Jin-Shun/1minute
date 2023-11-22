//
//  DayLog.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 22/11/23.
//

import Foundation

struct DayLog: Identifiable, Codable {
    var id = UUID()
    var date: Date
}
