//
//  ContentView.swift
//  Moonshot
//
//  Created by Farid Tabatabaie on 2022-08-04.
//

import SwiftUI

struct ContentView: View {
    @State private var usingGridView: Bool = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if usingGridView {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    usingGridView.toggle()
                } label: {
                    Text(usingGridView ? "Switch to List View" : "Switch to Grid View")
                    Image(systemName: usingGridView ? "square.fill.text.grid.1x2" : "square.grid.2x2.fill")
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
