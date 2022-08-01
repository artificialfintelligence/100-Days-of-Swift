//
//  ContentView.swift
//  Unit Converter
//
//  Created by Farid Tabatabaie on 2022-07-13.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemp = 0.0
    @State private var fromUnit = "Celsius"
    @State private var toUnit = "Fahrenheit"
    @FocusState private var inputTempIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var inputTempInCelsius: Double? {
        switch fromUnit {
        case "Celsius": return inputTemp
        case "Fahrenheit": return (inputTemp - 32) * 5 / 9
        case "Kelvin": return inputTemp - 273.15
        default: return nil
        }
    }
    
    var outputTemp: Double? {
        switch toUnit {
        case "Celsius": return inputTempInCelsius!
        case "Fahrenheit": return inputTempInCelsius! * 9 / 5 + 32
        case "Kelvin": return inputTempInCelsius! + 273.15
        default: return nil
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $inputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputTempIsFocused)
                } header: {
                    Text("Input")
                } footer: {
                    Text(fromUnit == "Kelvin" ? "K" : fromUnit == "Celsius" ? "℃" : "℉")
                }
                Section {
                    Picker("Source Unit", selection: $fromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert from")
                }
                Section {
                    Picker("Destination Unit", selection: $toUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                Section {
                    Text(outputTemp!.formatted())
                } header: {
                    Text("Output")
                } footer: {
                    Text(toUnit == "Kelvin" ? "K" : toUnit == "Celsius" ? "℃" : "℉")
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("Temperature Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputTempIsFocused = false
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
