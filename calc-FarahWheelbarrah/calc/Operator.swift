//  Operator.swift
//  calc

/* Models an operator (e.g. +, -) in a mathematical expression.
 Creates a specific operator based on an input String */

import Foundation

class Operator: ExpressionTerm {
    let operatr: String
    let precedence: Int
    let operation: Operation
    
    // array of the calculator's supported operators
    static let operators = Array(operatorsAssociatedData.keys)

    // the lower the precedence value, the higher the operator's priority
    static let operatorsAssociatedData: [String: (precedence: Int, operation: Operation)] =
        ["x": (0, Multiplication()),
         "/": (0, Division()),
         "%": (0, Modulus()),
         "+": (1, Addition()),
         "-": (1, Subtraction())]
    
    init(operatr: String) {
        self.operatr = operatr
        let operatorData = Operator.operatorsAssociatedData[operatr]
        precedence = operatorData!.precedence
        operation = operatorData!.operation
    }

    override func expressionTerm() -> String {
        return String(operatr)
    }
}
