//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Farid Tabatabaie on 2022-08-03.
//

import Foundation

enum ExpenseType: String, CaseIterable, Codable {
    case personal = "Personal"
    case business = "Business"
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
