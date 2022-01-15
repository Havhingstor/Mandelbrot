//
//  ContentView.swift
//  Mandelbrot-GUI
//
//  Created by Paul on 14.01.22.
//

import SwiftUI

/// The resolution of the image in pixel per half dimension
var resolution: Double = 802
/// The range of calculated numbers
var range: Double = 2.5
/// The diameter of one unit
var unitSize: Double = 4
/// The number of calculating iterations
var iterations: UInt32 = 1000
/// The threshold for calculating the color of the values
var threshold: UInt32 = 18

/// The number of units per dimension
var unitNr: Int {
    Int(floor(resolution / unitSize - 0.5))
}

var intPerUnit: Double {
    range * 2 / Double(unitNr)
}

func transferX(x: Double) -> Double {
    x * unitSize + resolution / 2
}

func transferY(y: Double) -> Double {
    transferX(x: -y)
}

func optimizeRes() {
    let newUnitNr = ceil(resolution / unitSize - 0.5)
    resolution = unitSize * (newUnitNr + 0.5)
}

struct ContentView: View {
    @State var rangeX: [Int] = [Int] (-unitNr ..< unitNr)
    @State var rangeY: [Int] = [Int] (-unitNr ..< unitNr)

    var body: some View {
        ZStack {
            ForEach(rangeX, id: \.self) { x in
                ForEach(rangeY, id: \.self) { y in
                    if let col = getColor(x: Double(x), y: Double(y)) {
                        drawPoint(x: transferX(x: Double(x)), y: transferY(y: Double(y)), radius: unitSize / 2.0, color: col)
                    }
                }
            }
        }.frame(width: resolution , height: resolution, alignment: Alignment.center).background(Color.white)
    }
}

func getColor(x: Double, y: Double) -> Color? {
//    let nr = ComplexNumber(real: Double(x) / (Double(range) / 2.1) , imaginary: Double(-y) / (Double(range) / 2.1))
    let nr = ComplexNumber(real: x * intPerUnit, imaginary: y * intPerUnit)
    let val = isInMandelbrotSet(number: nr, iterations: iterations)
    if val == 0 {
        return .black
    } else if Double(val) > 0.9 * Double(threshold) {
        return .purple
    } else if Double(val) > 0.8 * Double(threshold) {
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

//func getPoints(x: Int, y: Int) -> (Double, Double) {
//    let x1 = x + 1
//    let y1 = y + 1
//
//    let compensation = Double(range)
//
//    let x2: Double = Double(x1) * radius * 2
//    let y2: Double = Double(y1) * radius * 2
//
//    let x3 = x2 + compensation * radius * 2
//    let y3 = y2 + compensation * radius * 2
//
//    return (x3, y3)
//}

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
