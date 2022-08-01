//
//  ContentView.swift
//  Multiplitainment
//
//  Created by Farid Tabatabaie on 2022-07-28.
//

import SwiftUI

struct Question {
    private var a: Int
    private var b: Int
    
    var answer: Int {
        a * b
    }
    
    static let maxOperand = 12
    
    static var fullMultiplicationTable: Array<Question> {
        var questions = Array<Question>()
        for i in 1...Self.maxOperand {
            questions.append(Question(i, i))
            for j in 1..<i {
                questions.append(Question(j, i))
                questions.append(Question(i, j))
            }
        }
        return questions
    }
    
    init(_ a: Int, _ b: Int) {
        self.a = a
        self.b = b
    }
    
    func questionString() -> String {
        return "\(a) x \(b) = "
    }
}

struct ContentView: View {
    @State private var difficultyLevel = 5
    @State private var numQuestionsOptions = [5, 10, 20]
    @State private var numQuestions = 10
    @State private var gameMode = false
    
    @State private var startButtonScalingAnim = 1.0
    @State private var startbuttonOpacityAnim = 1.0
    @State private var quitButtonScalingAnim = 2.0
    @State private var quitbuttonOpacityAnim = 0.0
    
    
    @State private var qCounter = 0
    @State private var score = 0
    @State private var askedQuestions = Array<Question>()
    @State private var recordedAnswers = Array<Int>()
    @State private var gameOver = false
    
    @State private var answer: Int? = nil
    @FocusState private var answerIsFocused: Bool
    
    let allQuestions = Question.fullMultiplicationTable
    @State private var currentQuestion = Question(1, 1)
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        if !gameMode {  // main menu
                            Section { VStack(alignment: .leading, spacing: 20) {
                                Text("Practice multiplication tables up to...")
                                Stepper("Difficulty level: \(difficultyLevel)", value: $difficultyLevel, in: 1...Question.maxOperand)
                            } }
                            Section { VStack(alignment: .leading, spacing: 20) {
                                Text("Number of questions: \(numQuestions)")
                                Picker("Choose the number of questions", selection: $numQuestions) {
                                    ForEach(numQuestionsOptions, id: \.self) {
                                        Text("\($0)")
                                    }
                                }
                                .pickerStyle(.segmented)
                            } }
                        }
                        else {  // gameMode
                            if !gameOver {  // game in progress
                                Section {
                                    Text("\(currentQuestion.questionString())❓")
                                    HStack {
                                        TextField("Type your answer here", value: $answer, format: .number)
                                            .keyboardType(.numberPad)
                                            .focused($answerIsFocused)
                                        Button("Submit") {
                                            if let answer = answer {
                                                if answer == currentQuestion.answer {
                                                    score += 1
                                                }
                                                withAnimation {
                                                    askedQuestions.append(currentQuestion)
                                                    recordedAnswers.append(answer)
                                                    askQuestion()
                                                }
                                                
                                            }
                                        }
                                        .frame(width: 100, height: 50)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                } footer: {
                                    HStack {
                                        Text("Score: \(score) / \(qCounter - 1)")
                                        Spacer()
                                        Text(qCounter == numQuestions ? "Last one!" : "\(numQuestions - qCounter + 1) more to go!")
                                    }
                                }
                                Section {
                                    VStack(alignment: .leading, spacing: 5) {
                                        ForEach(0..<askedQuestions.count, id: \.self) { index in
                                            let xoSymbol = recordedAnswers[index] == askedQuestions[index].answer ? "⭕️" : "❌"
                                            Text("\(xoSymbol) \(askedQuestions[index].questionString()) \(recordedAnswers[index])")
                                        }
                                    }
                                }
                            }
                            else {  // gameOver; showing final score
                                VStack {
                                    Text("You scored \(score) / \(numQuestions)")
                                    Text("Tap Quit to go back to the main menu.")
                                }
                                Section {
                                    VStack(alignment: .leading, spacing: 5) {
                                        ForEach(0..<askedQuestions.count, id: \.self) { index in
                                            let xoSymbol = recordedAnswers[index] == askedQuestions[index].answer ? "⭕️" : "❌"
                                            HStack(spacing: 10) {
                                                Text("\(xoSymbol) \(askedQuestions[index].questionString()) \(recordedAnswers[index])")
                                                if xoSymbol == "❌" {
                                                    Text("👉 \(askedQuestions[index].questionString()) \(askedQuestions[index].answer)")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    .navigationTitle("Multiplitainment!")
                    .frame(alignment: .center)
                }
                
                VStack {
                    if !gameMode {  // main menu
                        Spacer()
                        
                        
                        Button("Start!") {
                            startGame()
                            withAnimation {
                                gameMode.toggle()
                                answerIsFocused.toggle()
                            }
                        }
                        .padding()
                        .frame(width: 100, height: (gameMode ? 50 : 100), alignment: .center)
                        .overlay(Rectangle()
                            .stroke(.blue)
                            .scaleEffect(startButtonScalingAnim)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: startButtonScalingAnim)
                                .opacity(startbuttonOpacityAnim)
                                .animation(
                                    .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                    value: startbuttonOpacityAnim)
                        )
                        .onAppear {
                            startButtonScalingAnim = 2.0
                            startbuttonOpacityAnim = 0.0
                        }
                        
                        Spacer()
                    }
                    else {  // gameMode
                        Button("Quit", role: .destructive) {
                            if gameOver {   // Now showing final score; tap to go back to main menu
                                gameOver = false
                            }
                            askedQuestions = Array<Question>()
                            recordedAnswers = Array<Int>()
                            withAnimation {
                                gameMode.toggle()
                            }
                        }
                        .padding()
                        .frame(width: 100, height: (gameMode ? 50 : 100), alignment: .center)
                        .overlay(Rectangle()
                            .stroke(.red)
                            .scaleEffect(quitButtonScalingAnim)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: quitButtonScalingAnim)
                                .opacity(quitbuttonOpacityAnim)
                                .animation(
                                    .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                    value: quitbuttonOpacityAnim)
                        )
                    }
                }
            }
        }
    }
    
    func askQuestion() {
        if qCounter == numQuestions {
            gameOver = true
            quitButtonScalingAnim = 1.0
            quitbuttonOpacityAnim = 1.0
        }
        else {
            answer = nil
            answerIsFocused.toggle()
            currentQuestion = allQuestions[Int.random(in: 0..<difficultyLevel * difficultyLevel)]
            qCounter += 1
        }
    }
    
    func startGame() {
        qCounter = 0
        score = 0
        startButtonScalingAnim = 1.0
        startbuttonOpacityAnim = 1.0
        quitButtonScalingAnim = 2.0
        quitbuttonOpacityAnim = 0.0

        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
