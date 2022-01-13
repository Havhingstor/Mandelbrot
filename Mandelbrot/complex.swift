//
//  complex.swift
//  Mandelbrot
//
//  Created by Paul on 13.01.22.
//

import Foundation

public class ComplexNumber: CustomStringConvertible {
    public var description: String {
        if real != 0 && imaginary != 0 {
           if imaginary != 1 && imaginary != -1 && imaginary > 0 {
                return "\(real) + \(imaginary)i"
            } else if imaginary != 1 && imaginary != -1 && imaginary < 0 {
                return "\(real) - \(-imaginary)i"
            }
            else if imaginary == -1 {
                return "\(real) - i"
            }
            else {
                return "\(real) + i"
            }
        } else if real == 0 && imaginary != 0 {
            if imaginary != 1 && imaginary != -1 {
                return "\(imaginary)i"
            } else if imaginary == -1 {
                return "-i"
            }
            else {
                return "i"
            }
        } else if real != 0 && imaginary == 0 {
            return "\(real)"
        } else {
            return "0"
        }
    }
    
    private var real: Int
    private var imaginary: Int
    
    init(real: Int = 0, imaginary: Int = 0) {
        self.real = real
        self.imaginary = imaginary
    }
    
    public func sqr() -> ComplexNumber {
        let p1 = real * real
        let p2 = 2 * real * imaginary
        let p3 = imaginary * imaginary
        
        let newReal = p1 - p3
        
        return ComplexNumber(real: newReal, imaginary: p2)
    }
    
    public func add(_ val: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: real + val.real, imaginary: imaginary + val.imaginary)
    }
    
    public var realExternal: Int {
        real
    }
    
    public var imaginaryExternal: Int {
        imaginary
    }
    
    public var absolute: Double {
        sqrt(Double(real * real + imaginary * imaginary))
    }
}

/// - Returns: The number of steps needed to get a number with an absolute value higher than 2. Returns 0, if no such value was found.
public func isInMandelbrotSet(number num: ComplexNumber, iterations its: Int) -> Int {
    var val = ComplexNumber()
    for i in 1 ... its {
        val = val.sqr()
        val = val.add(num)
        if val.absolute > 2 {
            return i
        }
    }
    return 0
}
