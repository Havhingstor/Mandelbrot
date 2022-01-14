//
//  ContentView.swift
//  Mandelbrot-GUI
//
//  Created by Paul on 14.01.22.
//

import SwiftUI
import Mandelbrot

let size = 450
let range: UInt32 = 90
let iterations = 1000
let threshold = 18

var radius: Double {
    Double(size) / (Double(range) * 2)
}

struct ContentView: View {
    @State var rangeX: [Int] = [Int] (-Int(range) ... Int(range))
    @State var rangeY: [Int] = [Int] (-Int(range) ... Int(range))

    var body: some View {
        ZStack {
            ForEach(rangeX, id: \.self) { x in
                ForEach(rangeY, id: \.self) { y in
                    let coords = getPoints(x: x, y: y)
                    if let col = getColor(x: x, y: y) {
                        drawPoint(x: coords.0, y: coords.1, radius: radius, color: col)
                    }
                }
            }
        }.frame(width: Double(size) * 2 + 3 * radius , height: Double(size) * 2 + 3 * radius, alignment: Alignment.center).background(Color.white)
    }
}

func getColor(x: Int, y: Int) -> Color? {
    let nr = ComplexNumber(real: Double(x) / (Double(range) / 2.1) , imaginary: Double(-y) / (Double(range) / 2.1))
    let val = isInMandelbrotSet(number: nr, iterations: iterations)
    if val == 0 {
        return .black
    } else if Double(val) > 0.9 * Double(threshold) {
        return .purple
    } else if Double(val) > 0.9 * Double(threshold) {
        return .blue
    } else if Double(val) > 0.75 * Double(threshold) {
        return .green
    } else if Double(val) > 0.6 * Double(threshold) {
        return .red
    } else if Double(val) > 0.5 * Double(threshold) {
        return .orange
    } else if Double(val) > 0.4 * Double(threshold) {
        return .yellow
    } else {
        return nil
    }
}

func getPoints(x: Int, y: Int) -> (Double, Double) {
    let x1 = x + 1
    let y1 = y + 1
    
    let compensation = Double(range)
    
    let x2: Double = Double(x1) * radius * 2
    let y2: Double = Double(y1) * radius * 2
    
    let x3 = x2 + compensation * radius * 2
    let y3 = y2 + compensation * radius * 2
    
    return (x3, y3)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func drawPoint(x: Double, y: Double, radius r: Double, color c: Color)->some View {
//    print("P(\(x)|\(y))")
    return Path() { path in
        path.addArc(center: CGPoint(x: x, y: y), radius: r, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360.0), clockwise: true)
    }.foregroundColor(c)
}

private func drawRoute(koordinaten kListe: [([String: Double], UUID)], width w: Double, color c: Color)->some View {
    var k = kListe
    return Path({ path in
        let start = k.removeFirst()
        path.move(to: CGPoint(x: start.0["x"]!, y: start.0["y"]!))
        
        for p in k {
            path.addLine(to: CGPoint(x: p.0["x"]!, y: p.0["y"]!))
        }
    }).stroke(c, lineWidth: w).frame(width: 750, height: 600)
}
