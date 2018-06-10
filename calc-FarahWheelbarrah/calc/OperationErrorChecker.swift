//  OperationErrorChecker.swift
//  calc

/* Encapsulates helper functions for checking
 certain mathematical operation errors */

import Foundation

struct OperationErrorChecker {
    
    static func checkForOverflow(_ overflowReport: (partialValue: Int, overflow: Bool), _ operand1: Int, _ operand2: Int, _ operatr: String) throws {
        if overflowReport.overflow {
            if operatr == "x" {
                try checkMultiplyOverflow(operand1, operand2, operatr)
            } else {
                try checkAddAndSubtractOverflow(overflowReport.partialValue, operand1, operand2, operatr)
            }
        }
    }
    
    static func checkMultiplyOverflow(_ op1: Int, _ op2: Int, _ operatr: String) throws {
        // if-statement condition source: https://www.geeksforgeeks.org/detect-if-two-integers-have-opposite-signs/
        if op1 ^ op2 < 0 {
            // signs are different (i.e. one number is positive and the other, negative), hence, negative overflow (underflow)
            throw ExpressionError.integerUnderflow(operand1: op1, operand2: op2, operatr: operatr)
        }
        // signs are the same, hence, positive overflow
        throw ExpressionError.integerOverflow(operand1: op1, operand2: op2, operatr: operatr)
    }
    
    static func checkAddAndSubtractOverflow(_ partialValue: Int, _ op1: Int, _ op2: Int, _ operatr: String) throws {
        if partialValue < 0 {
            // positive overflow
            throw ExpressionError.integerOverflow(operand1: op1, operand2: op2, operatr: operatr)
        }
        // negative overflow (underflow)
        throw ExpressionError.integerUnderflow(operand1: op1, operand2: op2, operatr: operatr)
    }
    
    static func divisionByZero(_ operand2: Operand) throws {
        if operand2.operand == 0 {
            throw ExpressionError.divisionByZero
        }
    }
}
