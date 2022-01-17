//
//  ContentView.swift
//  Mandelbrot-GUI
//
//  Created by Paul on 14.01.22.
//

import SwiftUI

struct ContentView: View {
    /// The resolution of the image in pixel per half dimension
    @Binding var resolution: Double
    /// The half range of calculated numbers
    @Binding var range: Double
    /// The number of units per half dimension
    @Binding var unitNr: UInt32
    /// The number of calculating iterations
    @Binding var iterations: UInt32
    /// The threshold for calculating the color of the values
    @Binding var threshold: UInt32
    
   let colors: [[Color?]] = [
    [nil,   nil,    .black,    nil,    nil,    nil],
    [nil,   .black,    .black,     .black,    nil,   nil],
        [nil,    nil, nil, nil, nil,nil],
        [nil,nil, nil, nil, nil,nil],
        [nil,   nil, nil, nil, nil,nil],
        [.black,   .black, .black, .black, .black,nil]
    ]
    
    /// The number of units per half dimension
    var unitSize: Double {
        (resolution - 10) / (Double(unitNr) + 0.5)
    }
    
    var intPerUnit: Double {
        range / Double(unitNr)
    }
    
    func transfer(val: Double) -> Double {
        val * unitSize + resolution
    }
    
    func render() -> [(Path, Color, UUID)]{
//        print("\(unitNr)\n\((-2) / intPerUnit)")
        var units: [[Unit?]] = []
        
        let rangeX: [Int] = [Int] (-Int(unitNr) ..< Int(unitNr))
        let rangeY: [Int] = [Int] (-Int(unitNr) ..< Int(unitNr))
        
//        let rangeX: [Int] = [Int] (0 ..< 5)
//        let rangeY: [Int] = [Int] (0 ..< 5)
        
        
        
        for y in rangeY {
            var addition: [Unit?] = []
            for x in rangeX {
                let iX = x + Int(unitNr)
                let iY = y + Int(unitNr)
                if let col = getColor(x: Double(x), y: Double(y)) {
//                if let col = colors[iY][iX] {
                    let up = iY > 0 ? units[iY - 1][iX] : nil
                    let left = iX > 0 ? addition[iX - 1] : nil
                    let unit = Unit(c: col, up: up, left: left, x: x, y: y)
                    addition.append(unit)
                } else {
                    addition.append(nil)
                }
            }
            units.append(addition)
        }
        
        var result: [(Path, Color, UUID)] = []
        
        var colors: [UUID : Color] = [:]
        
        var groupLists: [UUID : [(Point, Point)]] = [:]
        
//        for y in rangeY {
//            for x in rangeX {
//                if let unit = units[y][x] {
//                    let gid = unit.group.groupID
//                    if groups[gid] != nil {
//                        groups[gid]!.append(unit)
//                    } else {
//                        groups.updateValue([unit], forKey: gid)
//                    }
//                }
//            }
//        }
        
        
        for y in rangeY {
            for x in rangeX {
                let iX = x + Int(unitNr)
                let iY = y + Int(unitNr)
                if let unit = units[iY][iX] {
                    let gID = unit.group.groupIDExternal
                    if var list = groupLists[gID] {
                        drawUnit(x: transfer(val: Double(x)), y: transfer(val: Double(y)), radius: unitSize / 2.0, unit: unit, list: &list)
                        
//                        let nx = 200 + Double(x) * unitSize, ny = 200 + Double(y) * unitSize, r = unitSize / 2.0
                        
                        
                        
//                        let c1 = CGPoint(x: nx - r, y: ny - r)
//                        let c2 = CGPoint(x: nx + r, y: ny - r)
//                        let c3 = CGPoint(x: nx + r, y: ny + r)
//                        let c4 = CGPoint(x: nx - r, y: ny + r)
//
//                        var printed = false
//
//                        if !unit.upConnectExternal {
////                        if true {
//                            path.move(to: c1)
//                            path.addLine(to: c2)
//                            print("Up Printed")
//                            printed = true
//                        }
//
//                        if !unit.rightConnectExternal {
////                        if true {
//                            path.move(to: c2)
//                            path.addLine(to: c3)
//                            print("Right Printed")
//                            printed = true
//                        }
//
//                        if !unit.downConnectExternal {
////                        if true {
//                            path.move(to: c3)
//                            path.addLine(to: c4)
//                            print("Down Printed")
//                            printed = true
//                        }
//
//                        if !unit.leftConnectExternal {
////                        if true {
//                            path.move(to: c4)
//                            path.addLine(to: c1)
//                            print("Left Printed")
//                            printed = true
//                        }
//
//                        if !printed {
//                            print("nothing")
//                        }
//
//                        print("\(gID)\n")
                        
                        
                        groupLists.updateValue(list, forKey: gID)
                    } else {
                        var list: [(Point, Point)] = []
//                        let nx = 200 + Double(x) * unitSize, ny = 200 + Double(y) * unitSize, r = unitSize / 2.0
                        drawUnit(x: transfer(val: Double(x)), y: transfer(val: Double(y)), radius: unitSize / 2.0, unit: unit, list: &list)
                        
                        
                        
//                        let c1 = CGPoint(x: nx - r, y: ny - r)
//                        let c2 = CGPoint(x: nx + r, y: ny - r)
//                        let c3 = CGPoint(x: nx + r, y: ny + r)
//                        let c4 = CGPoint(x: nx - r, y: ny + r)
//
//                        if !unit.upConnectExternal {
////                        if true {
//                            path.move(to: c1)
//                            path.addLine(to: c2)
//                        }
//
//                        if !unit.rightConnectExternal {
////                        if true {
//                            path.move(to: c2)
//                            path.addLine(to: c3)
//                        }
//
//                        if !unit.downConnectExternal {
////                        if true {
//                            path.move(to: c3)
//                            path.addLine(to: c4)
//                        }
//
//                        if !unit.leftConnectExternal {
////                        if true {
//                            path.move(to: c4)
//                            path.addLine(to: c1)
//                        }

                        
                        
                        
                        groupLists.updateValue(list, forKey: gID)
                        colors.updateValue(unit.colorExternal, forKey: gID)
                    }
                }
            }
        }
        
        for vals in groupLists {
            var path = Path()
            
            var list = vals.value
            if list.isEmpty {
                continue
            }
            let start = list[0].0
            path.move(to: start.cgpoint)

//            print("Start: \(start), Group: \(vals.key)")

            var current = start

            repeat {
                Point.dist = unitSize
                let newVal = list.first() { val in
                    val.0 == current
                }

                if newVal != nil {
                    current = newVal!.1
                    list.removeAll() {val in
                        val == newVal!
                    }
//                    print("Next Val: \(current)")
                } else {
//                    print("No new Value for \(current)!")
//                    for val in list {
//                        print(val)
//                    }
//                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    print("Error, problems can occur")
                    break
                }

                path.addLine(to: current.cgpoint)
            } while current != start
            
//            for val in list {
//                path.move(to: val.0.cgpoint)
//                path.addLine(to: val.1.cgpoint)
//            }
            
               result.append((path, colors[vals.key]!, UUID()))
        }
        
        return result
    }
    
    var body: some View {
        @State var rangeX: [Int] = [Int] (-Int(unitNr) ..< Int(unitNr))
        @State var rangeY: [Int] = [Int] (-Int(unitNr) ..< Int(unitNr))
        
        @State var view = render()
        
        return ZStack {
            
            ForEach(view, id: \.2) { vals in
                vals.0.fill(vals.1)
            }
            drawPoint(x: transfer(val: -2.1 / intPerUnit), y: transfer(val: -2.1 / intPerUnit), radius: 5, color: .red)
//            ForEach(rangeX, id: \.self) { x in
//                ForEach(rangeY, id: \.self) { y in
//                    VStack(alignment: .center) {
//                        Spacer().frame(maxHeight: transfer(val: Double(y)))
//                        HStack {
//                            Spacer().frame(maxWidth: transfer(val: Double(x)))
//                            Text("\(x)-\(y)").foregroundColor(.black).font(.system(size: 12))
//                            Spacer()
//                        }.padding()
//                        Spacer()
//                    }.padding()
//                }
//            }
//            Path() { path in
//                path.move(to: CGPoint(x: 100, y: 100))
//                path.addLine(to: CGPoint(x: 200, y: 200))
//                path.move(to: CGPoint(x: 300, y: 300))
//                path.addLine(to: CGPoint(x: 350, y: 350))
//            }.stroke(.black)
        }.frame(width: resolution * 2, height: resolution * 2).background(Color.white)
    }
    
    func getColor(x: Double, y: Double) -> Color? {
        //    let nr = ComplexNumber(real: Double(x) / (Double(range) / 2.1) , imaginary: Double(-y) / (Double(range) / 2.1))
        let nr = ComplexNumber(real: x * intPerUnit, imaginary: (-y) * intPerUnit)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

private func drawPoint(x: Double, y: Double, radius r: Double, color c: Color)->some View {
//    print("P(\(x)|\(y))")
    Path() { path in
        path.addRect(CGRect(x: x - r, y: y - r, width: 2 * r, height: 2 * r))
    }.fill(c)
}

private func drawUnit(x: Double, y: Double, radius r: Double, unit: Unit, list: inout [(Point, Point)]) {
    let c1 = Point(x: x - r, y: y - r)
    let c2 = Point(x: x + r, y: y - r)
    let c3 = Point(x: x + r, y: y + r)
    let c4 = Point(x: x - r, y: y + r)
    
    if !unit.upConnectExternal {
//    if true {
        list.append((c1, c2))
//        print("Added Val: (C1,C2) \((c1, c2)), Group: \(unit.group.groupIDExternal) / \(unit.group)")
    }
    
    if !unit.rightConnectExternal {
//    if true {
        list.append((c2, c3))
//        print("Added Val: (C2,C3) \((c2, c3)), Group: \(unit.group.groupIDExternal) / \(unit.group)")
    }
    
    if !unit.downConnectExternal {
//    if true {
        list.append((c3, c4))
//        print("Added Val: (C3,C4) \((c3, c4)), Group: \(unit.group.groupIDExternal) / \(unit.group)")
    }
    
    if !unit.leftConnectExternal {
//    if true {
        list.append((c4, c1))
//        print("Added Val: (C3,C4) \((c4, c1)), Group: \(unit.group.groupIDExternal) / \(unit.group)")
    }
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

struct Point: CustomStringConvertible, Equatable {
    let x: Double
    let y: Double
    static var dist: Double = 1
    
    var description: String {
        "P(\(x)|\(y))"
    }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return abs(lhs.x - rhs.x) < 0.01 * dist && abs(lhs.y - rhs.y) < 0.01 * dist
    }
    
    public var cgpoint: CGPoint {
        CGPoint(x: x, y: y)
    }
}
