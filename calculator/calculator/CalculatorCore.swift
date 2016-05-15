//
//  CalculatorCore.swift
//  calculator
//
//  Created by Cor Pruijs on 28-04-16.
//  Copyright © 2016 CorCoder. All rights reserved.
//

import Foundation

class CalculatorCore {
    
    // MARK: - Properties
    private var accumulator = 0.0
    private var operations = [String:Operation]()
    private var history = [String]()
    
    internal var description: String {
        get {
            return history.joinWithSeparator(" ")
        }
    }
    
    internal var resultIsPartial: Bool {
        get {
            return pending != nil
        }
    }
    
    // MARK: - Initalization
    init() {
        initializeOperations()
    }
    
    private func initializeOperations() {
        
        // Constants
        operations["π"] = .constant(M_PI)
        operations["e"] = .constant(M_E)
        operations["C"] = .constant(Double(0))
        
        // Unary Operations
        operations["√"] =   .unaryOperation(sqrt)
        operations["cos"] = .unaryOperation(cos)
        operations["sin"] = .unaryOperation(sin)
        operations["tan"] = .unaryOperation(tan)
        operations["±"] =   .unaryOperation({ -$0 })
        
        // Binary Operations
        operations["×"] = .binaryOperation(*)
        operations["+"] = .binaryOperation(+)
        operations["−"] = .binaryOperation(-)
        operations["÷"] = .binaryOperation(/)
        
        // Equals
        operations["="] = .equals
    }
    

    // MARK: - Internal Interface
    internal var result: Double {
        get {
            return accumulator
        }
    }
    
    internal func setOperand(operand: Double) {
        accumulator = operand
        history.append(String(operand))
    }
    
    internal func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                executePendingBinaryOperation()
            }
        } else {
            print("Operation \(symbol) doesn't exist")
        }
        history.append(symbol)
    }
    
    internal func reset() {
        accumulator = 0.0
        pending = nil
        history = []
    }
    
    // MARK: - Binary Operation Logic
    private struct PendingBinaryOperationInfo {
        let binaryFunction: (Double, Double) -> Double
        let firstOperand: Double
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    // MARK: - Operation Type
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
}