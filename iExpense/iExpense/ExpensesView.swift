//
//  ContentView.swift
//  iExpense
//
//  Created by Farid Tabatabaie on 2022-08-02.
//

import SwiftUI

struct TricolorFormatModifier: ViewModifier {
    var valueToBeFormatted: Double
    
    func body(content: Content) -> some View {
        if valueToBeFormatted < 10 {
            content.foregroundColor(.green)
        }
        else if valueToBeFormatted >= 10 && valueToBeFormatted < 100 {
            content.foregroundColor(.orange)
        }
        else if valueToBeFormatted >= 100 {
            content.foregroundColor(.red)
        }
    }
}

extension View {
    func tricolorFormatConditional(on value: Double) -> some View {
        modifier(TricolorFormatModifier(valueToBeFormatted: value))
    }
}

struct ExpensesView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseType.allCases, id: \.self) { expenseType in
                    Section("\(expenseType.rawValue) Expenses") {
                        ForEach(expenses.items.filter({ $0.type == expenseType })) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type.rawValue)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .tricolorFormatConditional(on: item.amount)
                            }
                        }
                        .onDelete(perform: { indexSet in expenses.removeItems(ofType: expenseType, at: indexSet) })
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
