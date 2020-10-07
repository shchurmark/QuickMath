//
//  EquationGenerator.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/15/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

import Foundation

enum Difficulty {
    case none, easy, medium, hard
}

enum Operator {
    case none, addition, subtraction, multiplication, division
}

class EquationGenerator {
    var x = 0, y = 0, z = 0, fullEquation = ""
    var difficulty: Difficulty = .none //default value, results in error.
    var operationType: Operator = .none //default value, results in error.
    
    func generateNewEquation() {
        switch operationType {
            
        case .none:
            print("error in EQNGenerator")
        case .addition:
            doAddition(with: difficulty)
        case .subtraction:
            doSubtraction(with: difficulty)
        case .multiplication:
            doMultiplication(with: difficulty)
        case .division:
            doDivision(with: difficulty)
        }
    }
    
    private func doAddition(with diff: Difficulty) {
        switch diff {
            
        case .none:
            print("Error in EQNG : doAddition()")
        case .easy:
            x = Int.random(in: 1...10)
            y = Int.random(in: 1...10)
            z = x + y
        case .medium:
            x = Int.random(in: 10...100)
            y = Int.random(in: 10...100)
            z = x + y
        case .hard:
            x = Int.random(in: 100...10000)
            y = Int.random(in: 100...10000)
            z = x + y
        }
    }
    
    private func doSubtraction(with diff: Difficulty) {
        switch diff {
            
        case .none:
            print("Error in EQNG : doSubtraction()")
        case .easy:
            x = Int.random(in: 1...10)
            y = Int.random(in: 1...10)
            z = x - y
        case .medium:
            x = Int.random(in: 10...100)
            y = Int.random(in: 10...100)
            z = x - y
        case .hard:
            x = Int.random(in: 100...10000)
            y = Int.random(in: 100...10000)
            z = x - y
        }
    }
    
    private func doMultiplication(with diff: Difficulty) {
        switch diff {
        case .none:
            print("Error in EQNG : doMulti()")
        case .easy:
            x = Int.random(in: 1...5)
            y = Int.random(in: 1...5)
            z = x * y
        case .medium:
            x = Int.random(in: 2...11)
            y = Int.random(in: 2...11)
            z = x * y
        case .hard:
            x = Int.random(in: 7...100)
            y = Int.random(in: 7...100)
            z = x * y
        }
    }
    
    private func doDivision(with diff: Difficulty) {
        switch diff {
        case .none:
            print("Error in EQNG : doDivi()")
        case .easy:
            repeat {
                x = Int.random(in: 1...5)
                y = Int.random(in: 1...5)
            } while(!(x.isMultiple(of: y)))
            z = x / y
        case .medium:
            repeat {
                x = Int.random(in: 2...33)
                y = Int.random(in: 2...33)
            } while(!(x.isMultiple(of: y)))
            z = x / y
        case .hard:
            repeat {
                x = Int.random(in: 7...100)
                y = Int.random(in: 7...100)
            } while(!(x.isMultiple(of: y)))
            z = x / y
        }
    }
}
