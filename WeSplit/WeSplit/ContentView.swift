//
//  ContentView.swift
//  WeSplit
//
//  Created by Farid Tabatabaie on 2022-07-12.
//

import SwiftUI

struct FormatTextAccordingToWarningState: ViewModifier {
    var warningState: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(warningState ? .red : .primary)
    }
}

extension View {
    func formatWithWarning(if warningState: Bool) -> some View {
        modifier(FormatTextAccordingToWarningState(warningState: warningState))
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var indexOfNumPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 25, 30, 0]
    
    var numPeople: Double {
        Double(indexOfNumPeople + 2)
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        grandTotal / numPeople
    }
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $indexOfNumPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
//                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                        .formatWithWarning(if: tipPercentage == 0)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text(grandTotal, format: currencyFormat)
                        .formatWithWarning(if: tipPercentage == 0)
                }  header: {
                    Text("Grand total")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
