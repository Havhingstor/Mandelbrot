//
//  Mandelbrot_GUIApp.swift
//  Mandelbrot-GUI
//
//  Created by Paul on 14.01.22.
//

import SwiftUI

@main
struct Mandelbrot_GUIApp: App {
    /// The resolution of the image in pixel per half dimension
    @State var resolution: Double = 802
    /// The range of calculated numbers
    @State var range: Double = 2.1
    /// The diameter of one unit
    @State var unitSize: Double = 4
    /// The number of calculating iterations
    @State var iterations: UInt32 = 1000
    /// The threshold for calculating the color of the values
    @State var threshold: UInt32 = 18
    
    @State var resolutionStr = "802"
    @State var rangeStr = "2.1"
    @State var unitSizeStr = "4"
    @State var iterationsStr = "1000"
    @State var thresholdStr = "18"
    
    func optimizeRes() {
        let newUnitNr = ceil(resolution / unitSize - 0.5)
        resolution = unitSize * (newUnitNr + 0.5)
    }
    
    func reload() {
        
        resolution = Double(resolutionStr) ?? 802
        
        range = Double(rangeStr) ?? 2.1
        
        unitSize = Double(unitSizeStr) ?? 4
        
        iterations = UInt32(iterationsStr) ?? 1000
        
        threshold = UInt32(thresholdStr) ?? 18
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(resolution: $resolution, range: $range, unitSize: $unitSize, iterations: $iterations, threshold: $threshold)
        }
        .commands {
            CommandGroup(after: .printItem) {
                Button("Reload") {
                    reload()
                }.keyboardShortcut("r")
            }
            CommandGroup(after: .printItem) {
                Button("Optimize") {
                    optimizeRes()
                }.keyboardShortcut("o")
            }
        }
        
        Settings {
            SettingsWindow(resolutionStr: $resolutionStr, rangeStr: $rangeStr, unitSizeStr: $unitSizeStr, iterationsStr: $iterationsStr, thresholdStr: $thresholdStr, app: self)
        }
    }
}

extension String  {
    var isDouble: Bool {
        if let _ = Double(self) {
            return true
        }
        return false
    }
    
    var isUInt32: Bool {
        if let _ = UInt32(self) {
            return true
        }
        return false
    }
}

struct SettingsWindow: View {
    @Binding var resolutionStr: String
    @Binding var rangeStr: String
    @Binding var unitSizeStr: String
    @Binding var iterationsStr: String
    @Binding var thresholdStr: String
    
    var app: Mandelbrot_GUIApp
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Resolution")
                TextField("Resolution", text: $resolutionStr).fixedSize().onChange(of: resolutionStr) { res in
                    if !(res.isDouble || res.isEmpty) {
                        resolutionStr = String(app.resolution)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                Text("Range")
                TextField("Range", text: $rangeStr).fixedSize().onChange(of: rangeStr) { range in
                    if !(range.isDouble || range.isEmpty) {
                        rangeStr = String(app.range)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                Text("UnitSize")
                TextField("UnitSize", text: $unitSizeStr).fixedSize().onChange(of: unitSizeStr) { us in
                    if !(us.isDouble || us.isEmpty) {
                        unitSizeStr = String(app.unitSize)
                    }
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Iterations")
                TextField("Iterations", text: $iterationsStr).fixedSize().onChange(of: iterationsStr) { it in
                    if !(it.isUInt32 || it.isEmpty) {
                        iterationsStr = String(app.iterations)
                    }
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Threshold")
                TextField("Threshold", text: $thresholdStr).fixedSize().onChange(of: thresholdStr) { th in
                    if !(th.isUInt32 || th.isEmpty) {
                        thresholdStr = String(app.threshold)
                    }
                }
                Spacer()
            }
            
            Button("Reload") {
                app.reload()
            }.keyboardShortcut(.defaultAction)
            Spacer()
        }
    }
}
