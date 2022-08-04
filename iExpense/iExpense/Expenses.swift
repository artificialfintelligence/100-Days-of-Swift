//
//  Expenses.swift
//  iExpense
//
//  Created by Farid Tabatabaie on 2022-08-03.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {            
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func removeItems(ofType type: ExpenseType, at offsets: IndexSet) {
        let itemToRemove = self.items.filter({ $0.type == type })[offsets.first!]
        let indexOfItemToRemove = self.items.firstIndex(where: { $0.id == itemToRemove.id })!
        
        self.items.remove(at: indexOfItemToRemove)
    }
}
