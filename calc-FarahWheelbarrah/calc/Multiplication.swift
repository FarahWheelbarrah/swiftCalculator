//  Multiplication.swift
//  calc

/* Encapsulates functions of the multiplication operation */

import Foundation

class Multiplication : Operation {
    
    override func evaluate(_ operand1: Operand, _ operand2: Operand) throws -> Operand {
        try checkIfMultiplicationOutOfBounds(operand1.operand, operand2.operand, "x")
        return Operand(operand: operand1.operand * operand2.operand)
    }
    
    func checkIfMultiplicationOutOfBounds(_ operand1: Int, _ operand2: Int, _ operatr: String) throws {
        let overflowReport = operand1.multipliedReportingOverflow(by: operand2)
        try OperationErrorChecker.checkForOverflow(overflowReport, operand1, operand2, operatr)
    }
}
