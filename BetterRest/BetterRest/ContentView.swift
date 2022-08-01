//
//  ContentView.swift
//  BetterRest
//
//  Created by Farid Tabatabaie on 2022-07-24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Wake-up time: \(wakeUp.formatted(date: .omitted, time: .shortened))", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            //.labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper("\(coffeeAmount) cup" + (coffeeAmount == 1 ? "" : "s"), value: $coffeeAmount, in: 1...20)
                    }
                }
                .navigationTitle("BetterRest")
//                .toolbar {
//                    Button("Calculate", action: calculateBedtime)
//                }
//                .alert(alertTitle, isPresented: $showingAlert) {
//                    Button("OK") { }
//                } message: {
//                    Text(alertMessage)
//                }
            }
            VStack(alignment: .center, spacing: 10) {
                Text("You should go to bed by:")
                    .font(.headline)
                Text("\(calculateBedtime().formatted(date: .omitted, time: .shortened))")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
        }
    }
    
    func calculateBedtime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = components.hour ?? 0
            let minutes = components.minute ?? 0
            let wakeUpMinsPastMidnight = hour * 60 * 60 + minutes * 60
            
            let prediction = try model.prediction(wake: Double(wakeUpMinsPastMidnight), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let bedTime = wakeUp - prediction.actualSleep
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
            return bedTime
        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was an error calculating your bedtime."
            return Date.now
        }
//        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
