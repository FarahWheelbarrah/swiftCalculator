//  Operand.swift
//  calc

/* Models a number/operand in a mathematical expression */

import Foundation

class Operand: ExpressionTerm {
    let operand: Int
    
    init(operand: Int) {
        self.operand = operand
    }

    override func expressionTerm() -> String {
        return String(operand)
    }
}
