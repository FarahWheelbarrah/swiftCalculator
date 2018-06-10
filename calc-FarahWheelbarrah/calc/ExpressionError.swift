//  ExpressionError.swift
//  calc

/* Enumeration for expression error types */

import Foundation

enum ExpressionError: Error {
    case incompleteExpression
    case unknownOperator(unknownOp: String)
    case invalidNumber(invalidNum: String)
    case divisionByZero
    case integerOverflow(operand1: Int, operand2: Int, operatr: String) // value > max Integer value
    case integerUnderflow(operand1: Int, operand2: Int, operatr: String) // value < min Integer value
}
