//  Expression.swift
//  calc

/* Models a mathematical expression in the
 form: [number] [operator number ...]
 Encapsulates logic related to parsing input into an expression,
 and evaluating expression to a single numerical answer */

import Foundation

struct Expression {
    let expressionArgs: [String]
    var expressionTerms: [ExpressionTerm] = []
    var precedenceValues: [Int] = [] // array of unique precendence values for this Expression instance
    
    // "answer" property must only be retrieved after processInputAndEvaluateExpression() function is called
    var answer: String {
        return inputExpression.expressionTerms.first!.expressionTerm()
    }
   
    init(expressionArgs: [String]) {
        self.expressionArgs = expressionArgs
    }
    
    mutating func processInputAndEvaluateExpression() throws {
        try parseInputExpression()
        try evaluateExpression()
    }
    
    mutating func parseInputExpression() throws {
        if Expression.isEven(expressionArgs.count) {
            throw ExpressionError.incompleteExpression
        }
        for (index, expressionArg) in expressionArgs.enumerated() {
            if Expression.isEven(index) {
                // current expressionArg should be an operand/number
                try appendOperand(expressionArg)
            } else  {
                // current expressionArg should be an operator
                try appendOperator(expressionArg)
            }
        }
    }
    
    mutating func evaluateExpression() throws {
        var index = 0
        for precedence in precedenceValues {
            while index < expressionTerms.count - 1 {
                if let operatr = expressionTerms[index] as? Operator, operatr.precedence == precedence {
                    // cast expression terms on either side of Operator to Operand types
                    let operand1 = expressionTerms[index - 1] as! Operand
                    let operand2 = expressionTerms[index + 1] as! Operand
                    
                    // evaluate operands, and assign to (overwrite) previous ExpressionTerm
                    try expressionTerms[index - 1] = operatr.operation.evaluate(operand1, operand2)
                    
                    // delete current and next expression terms
                    expressionTerms.removeSubrange(index...index + 1)
                    continue // index does not need incrementing; expressionTerms array resized; indexes shifted appropriately
                }
                index += 1
            }
            index = 0
        }
    }
    
    mutating func appendOperand(_ expressionArg: String) throws {
        guard let number = Int(expressionArg) else {
            throw ExpressionError.invalidNumber(invalidNum: expressionArg)
        }
        expressionTerms.append(Operand(operand: number))
    }
    
    mutating func appendOperator(_ expressionArg: String) throws {
        if !Operator.operators.contains(expressionArg) {
            throw ExpressionError.unknownOperator(unknownOp: expressionArg)
        }
        let operatr = Operator(operatr: expressionArg)
        expressionTerms.append(operatr)
        if !precedenceValues.contains(operatr.precedence) {
            insertUniquePrecedence(operatr.precedence)
        }
    }
    
    mutating func insertUniquePrecedence(_ newPrecedence: Int) {
        if precedenceValues.isEmpty {
            precedenceValues.append(newPrecedence)
        } else {
            insertUniquePrecedenceSorted(newPrecedence)
        }
    }
    
    // inserts a new precedence value (precedence values are in ascending order)
    mutating func insertUniquePrecedenceSorted(_ newPrecedence: Int) {
        for (index, precedence) in precedenceValues.enumerated() {
            if newPrecedence < precedence {
                precedenceValues.insert(newPrecedence, at: index)
                return
            }
        }
        precedenceValues.append(newPrecedence)
    }
    
    static func isEven(_ number: Int) -> Bool {
        return number % 2 == 0
    }
    
    static func errorMessage(of error: ExpressionError) -> String {
        switch error {
        case .divisionByZero:
            return "Division by zero"
        case let .integerOverflow(operand1, operand2, operatr):
            return "Integer Overflow: \(operand1) \(operatr) \(operand2) > \(Int.max)"
        case let .integerUnderflow(operand1, operand2, operatr):
            return "Integer Underflow: \(operand1) \(operatr) \(operand2) < \(Int.min)"
        case .incompleteExpression:
            return "Incomplete expression. Expected input of the form [number] [operator number ...]"
        case .invalidNumber(let invalidNum):
            return "Invalid number: \(invalidNum)"
        case .unknownOperator(let unknownOp):
            return "Unknown operator: \(unknownOp)"
        }
    }
}
