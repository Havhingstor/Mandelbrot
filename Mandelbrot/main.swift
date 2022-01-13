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

print(isInMandelbrotSet(number: ComplexNumber(real: -1, imaginary: 1), iterations: 50))
