//
//  Drawing_Sandbox5.swift
//  Drawing
//
//  Created by Farid Tabatabaie on 2022-08-15.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct RightArrow: Shape {
    var thickness: Double
    var arrowHeadSize: Double
    
    var animatableData: Double {
        get { thickness }
        set { thickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - arrowHeadSize, y: rect.midY - arrowHeadSize / 2))
        path.addLine(to: CGPoint(x: rect.maxX - arrowHeadSize, y: rect.midY + arrowHeadSize / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        
        path.move(to: CGPoint(x: rect.maxX - arrowHeadSize, y: rect.midY - thickness / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - thickness / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + thickness / 2))
        path.addLine(to: CGPoint(x: rect.maxX - arrowHeadSize, y: rect.midY + thickness / 2))
        path.closeSubpath()
                
        return path
    }
}

struct Drawing_Sandbox5: View {
    @State private var insetAmount = 50.0
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var arrowThickness = 1.0
    @State private var arrowHeadSize = 10.0

    var body: some View {
        VStack {
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 200, height: 100)
                .onTapGesture {
                    withAnimation {
                        insetAmount = Double.random(in: 1...99)
                    }
                }
            
            CheckerBoard(rows: rows, columns: columns)
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        rows = 8
                        columns = 16
                    }
                }
                .frame(width: 300, height: 300)
            
            RightArrow(thickness: arrowThickness, arrowHeadSize: arrowHeadSize)
                .frame(width: 300, height: 100)
            
            Text("Arrow thickness: \(Int(arrowThickness))")
            Slider(value: $arrowThickness, in: 1...10, step: 1)
                .padding([.horizontal, .bottom])
            
            Button {
                withAnimation {
                    arrowThickness = Double.random(in: 1...10)
                }
            } label: {
                Text("Random Thickness")
            }
        }
    }
}

struct Drawing_Sandbox5_Previews: PreviewProvider {
    static var previews: some View {
        Drawing_Sandbox5()
    }
}
