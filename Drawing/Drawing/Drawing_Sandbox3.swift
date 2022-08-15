//
//  Drawing_Sandbox3.swift
//  Drawing
//
//  Created by Farid Tabatabaie on 2022-08-14.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top, endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup() // to use Metal (for the gradient version)
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Drawing_Sandbox3: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 200, height: 200)
                .foregroundColor(.orange)
    //            .background(.red)
    //            .border(.red, width: 30)
    //            .background(Image("Example"))
                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.42), width: 50)
        
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.42), lineWidth: 25)
                .frame(width: 200, height: 100)
            
            VStack {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
                
                Slider(value: $colorCycle)
            }
        }
    }
}

struct Drawing_Sandbox3_Previews: PreviewProvider {
    static var previews: some View {
        Drawing_Sandbox3()
    }
}
