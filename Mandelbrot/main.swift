//
//  main.swift
//  Mandelbrot
//
//  Created by Paul on 13.01.22.
//

import Foundation

let i = ComplexNumber(real: 7, imaginary: -15)

print(i.add(ComplexNumber(real: -7, imaginary: 15)))
print(i.sqr())


print(ComplexNumber(real: 3, imaginary: 4).absolute)

print(isInMandelbrotSet(number: ComplexNumber(real: -0.33463, imaginary: 0.61804), iterations: 1000))
print()
print(isInMandelbrotSet(number: ComplexNumber(real: -0.2, imaginary: 0.5), iterations: 1000))
print(isInMandelbrotSet(number: ComplexNumber(real: -2.1, imaginary: 0), iterations: 1000))
