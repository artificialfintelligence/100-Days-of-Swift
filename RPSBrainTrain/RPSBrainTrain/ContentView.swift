//
//  ContentView.swift
//  RPSBrainTrain
//
//  Created by Farid Tabatabaie on 2022-07-21.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "✊"
    case paper = "✋"
    case scissors = "✌️"
}

struct ContentView: View {
    let numRounds = 10
    @State private var roundCounter = 1
    @State private var score = 0
    @State private var myMove = Move.allCases.randomElement()!
    @State private var playerShouldWin = Bool.random()
    @State private var gameOver = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var message = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                
                Text("Rock Paper Scissors\nBrain Training")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("You should:")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    Text((playerShouldWin ? "WIN" : "LOSE") + " against " + myMove.rawValue)
                        .font(.largeTitle.weight(.semibold))
                    
                    HStack(spacing: 10) {
                        ForEach(Move.allCases, id: \.self) { move in
                            Button {
                                moveTapped(move)
                            } label: {
                                Text(move.rawValue)
                                    .font(.system(size: 100))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Round \(roundCounter) / \(numRounds)")
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
            Button("Continue", action: moveOnToNextRound)
        } message: {
            Text("\(message)\nYour score is \(score)")
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("New Game", action: resetGame)
        } message: {
            Text("You scored \(score) / \(numRounds)")
        }
    }
    
    func moveTapped(_ move: Move) {
        var playerScored: Bool
        
        if playerShouldWin {
            playerScored = (move == whatBeats(myMove))
            message = "\(whatBeats(myMove).rawValue) beats \(myMove.rawValue)"
        }
        else {
            playerScored = (move == whatIsBeatenBy(myMove))
            message = "\(whatIsBeatenBy(myMove).rawValue) loses to \(myMove.rawValue)"
        }
        
        if playerScored {
            scoreTitle = "Well done!"
            score += 1
        }
        else {
            scoreTitle = "Uh-oh!"
        }
        
        showingScore = true
    }
    
    func moveOnToNextRound() {
        if roundCounter == numRounds {
            gameOver = true
        } else {
            roundCounter += 1
            myMove = Move.allCases.randomElement()!
            playerShouldWin = Bool.random()
        }
    }
    
    func resetGame() {
        score = 0
        roundCounter = 1
        myMove = Move.allCases.randomElement()!
        playerShouldWin = Bool.random()
    }
    
    func whatBeats(_ move: Move) -> Move {
        Move.allCases[(Move.allCases.firstIndex(of: move)! + 1) % 3]
    }
    
    func whatIsBeatenBy(_ move: Move) -> Move {
        Move.allCases[(Move.allCases.firstIndex(of: move)! + 2) % 3]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
