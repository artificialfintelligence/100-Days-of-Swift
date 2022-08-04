//
//  ContentView.swift
//  iExpense
//
//  Created by Farid Tabatabaie on 2022-08-02.
//

import SwiftUI

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Hello \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct Employee: Codable {
    let name: String
    let id: String
}

struct ContentView: View {
    @StateObject var user = User()
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Taps")
    @AppStorage("tapCount") private var tapCount = 0
    
    @State private var employee = Employee(name: "Taylor Swift", id: "t.swift")
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Static Row 1")
                    
                    ForEach(numbers, id:\.self) {
                        Text("Dynamic Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                    
                    Text ("Static Row 2")
                }
                VStack {
                    VStack {
                        Text("Your name is \(user.firstName) \(user.lastName)")

                        TextField("First name", text: $user.firstName)
                        TextField("Last name", text: $user.lastName)

                        Button("Add Row") {
                            numbers.append(currentNumber)
                            currentNumber += 1
                        }
                        
                        Button("Tap count: \(tapCount)") {
                            tapCount += 1
//                            UserDefaults.standard.set(tapCount, forKey: "Taps")
                        }
                        .padding()
                        
                        Button("Save employee: \(employee.id)") {
                            let encoder = JSONEncoder()
                            if let data = try? encoder.encode(employee) {
                                UserDefaults.standard.set(data, forKey: "EmployeeData")
                            }
                        }
                        .padding()
                        
                        Button("Show Sheet") {
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            SecondView(name: employee.name)
                        }
                    }
                }
            }
            .navigationTitle("SandBox")
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
