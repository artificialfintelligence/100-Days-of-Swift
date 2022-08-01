//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Farid Tabatabaie on 2022-07-16.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    private let numQuestions = 10
    @State private var qCounter = 1
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var message = ""
    @State private var gameOver = false
    
    @State private var tappedFlagIndex = 0
    @State private var rotationAmounts = [0.0, 0.0, 0.0]
    @State private var opacityAmounts = [1.0, 1.0, 1.0]
    @State private var scaleAmounts = [1.0, 1.0, 1.0]
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
        
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            tappedFlagIndex = number
                            withAnimation {
                                rotationAmounts[number] += 360
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(rotationAmounts[number]), axis: (x: 0, y: 0.5, z: 0))
                        .opacity(opacityAmounts[number])
                        .animation(.default, value: opacityAmounts)
                        .scaleEffect(scaleAmounts[number])
                        .animation(.default, value: scaleAmounts)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Question \(qCounter) / \(numQuestions)")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.medium))
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(message)\nYour score is \(score)")
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("New Game", action: resetGame)
        } message: {
            Text("You scored \(score) / \(numQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        opacityAmounts = opacityAmounts.enumerated().map { index, value in index == number ? 1.0 : 0.25 }
        scaleAmounts = scaleAmounts.enumerated().map { index, value in index == number ? 1.0 : 0.8 }
        if number == correctAnswer {
            scoreTitle = "Correct!"
            message = ""
            score += 1
        }
        else {
            scoreTitle = "Wrong!"
            message = "That's the flag of \(countries[number])."
        }
        showingScore = true
    }
    
    func askQuestion() {
        if qCounter == numQuestions {
            gameOver = true
        } else {
            qCounter += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        opacityAmounts = [1.0, 1.0, 1.0]
        scaleAmounts = [1.0, 1.0, 1.0]
    }
    
    func resetGame() {
        score = 0
        qCounter = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotationAmounts = [0.0, 0.0, 0.0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
