//
//  ContentView.swift
//  Animations
//
//  Created by Farid Tabatabaie on 2022-07-26.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var animationAmount1 = 1.0
    @State private var animationAmount2 = 1.0
    @State private var rotationAngle = 0.0
    @State private var enabled = false
    @State private var dragAmount1 = CGSize.zero
    @State private var dragAmount2 = CGSize.zero
    @State private var isShowingBlackBox = false
    @State private var isShowingGreen = false
    
    let letters = Array("Hello, SwiftUI")
    
    var body: some View {
        VStack {
            Spacer()
            
            Stepper("Scale amount", value: $animationAmount1.animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...5, step: 0.125)
            
            Spacer()
            
            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 100, height: 100)
            //            .padding(50)
            .background(enabled ? .red : .blue)
            .foregroundColor(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .scaleEffect(animationAmount1)
            .blur(radius: (animationAmount1 - 1) * 2.5)
            .animation(.default, value: animationAmount1)
            .animation(.default, value: enabled)
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    rotationAngle += 360
                    withAnimation {
                        isShowingBlackBox.toggle()
                    }
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount2)
                    .opacity(2 - animationAmount2)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: animationAmount2)
            )
            .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
            
            if isShowingBlackBox {
                Rectangle()
                    .fill(.black)
                    .frame(width: 400, height: 100)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Spacer()
            
            VStack {
                if isShowingGreen {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .frame(width: 300, height: 200)
                        .transition(.pivot)
                }
                else {
                    LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(dragAmount1)
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount1 = $0.translation }
                                .onEnded { _ in
                                    withAnimation {
                                        dragAmount1 = .zero
                                    }
                                }
                        )
                }
                //                    .animation(.spring(), value: dragAmount)
                
            }
            .onTapGesture {
                withAnimation {
                    isShowingGreen.toggle()
                }
            }
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id:\.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount2)
                        .animation(.default.delay(Double(num) / 20), value: dragAmount2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount2 = $0.translation }
                    .onEnded { _ in
                        dragAmount2 = .zero
                        enabled.toggle()
                    }
            )
            
            Spacer()
        }
        .onAppear {
            animationAmount2 = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
