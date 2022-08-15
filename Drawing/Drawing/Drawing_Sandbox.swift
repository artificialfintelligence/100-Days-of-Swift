//
//  Drawing_Sandbox.swift
//  Drawing
//
//  Created by Farid Tabatabaie on 2022-08-12.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
//        // Paul's way follows 'intuitive', clock-based conventions:
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        // My way conforms to trigonometrics conventions and Cartesian coordinates:
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: startAngle, endAngle: -endAngle, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Drawing_Sandbox: View {
    var body: some View {
        VStack {
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
                path.closeSubpath()
            }
//            .fill(.blue)
//            .stroke(.red, lineWidth: 10)
            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        
            Triangle()
//                .fill(.red)
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 250, height: 250)
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
//                .stroke(.blue, lineWidth: 40)
                .strokeBorder(.blue, lineWidth: 40)
                .frame(width: 300, height: 300)
            
            Circle()
//                .stroke(.blue, lineWidth: 40)
                .strokeBorder(.blue, lineWidth: 40)
        }
        .ignoresSafeArea()
    }
}

struct Drawing_Sandbox_Previews: PreviewProvider {
    static var previews: some View {
        Drawing_Sandbox()
    }
}
