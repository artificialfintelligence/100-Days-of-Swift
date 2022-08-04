//
//  ContentView.swift
//  Moonshot
//
//  Created by Farid Tabatabaie on 2022-08-04.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address:Codable {
    let street: String
    let city: String
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText View")
        self.text = text
    }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State private var dataForAlert = ""
    
    let layout = [
//        GridItem(.fixed(20)),
//        GridItem(.fixed(20)),
//        GridItem(.fixed(20))
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.8)
                    .frame(width: geo.size.width)   // , height: geo.size.height)
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<100) {
                        CustomText("Item \($0)")
                            .font(.title)
                    }
                }
//                .frame(maxWidth: .infinity)   // Not necessary for lazy stacks
            }
            
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(0..<100) {
                        Text("Item \($0)")
                    }
                }
            }
            
            NavigationView {
                List(0..<100) { row in
                    NavigationLink {
                        Text("Detail \(row)")
                    } label: {
                        Text("Row \(row)")
                            .padding()
                    }
                }
                .navigationTitle("SwiftUI")
                .toolbar {
                    Button("Decode JSON") {
                        let input = """
                        {
                            "name": "Taylor Swift",
                            "address": {
                                "street": "555 Taylor Swift Avenue",
                                "city": "Nashville"
                            }
                        }
                        """
                        
                        let data = Data(input.utf8)
                        
                        if let user = try? JSONDecoder().decode(User.self, from: data) {
                            dataForAlert = user.address.street + ", " + user.address.city
                            showingAlert = true
                        }
                    }
                }
            }
        }
        .alert("JSON Decoding Result", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("The message was:\n\(dataForAlert)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
