//  Subtraction.swift
//  calc

/* Encapsulates functions of the subtraction operation */

import Foundation

class Subtraction : Operation {
    
    override func evaluate(_ operand1: Operand, _ operand2: Operand) throws -> Operand {
        try checkIfSubtractionOutOfBounds(operand1.operand, operand2.operand, "-")
        return Operand(operand: operand1.operand - operand2.operand)
    }
    
    func checkIfSubtractionOutOfBounds(_ operand1: Int, _ operand2: Int, _ operatr: String) throws {
        let overflowReport = operand1.subtractingReportingOverflow(operand2)
        try OperationErrorChecker.checkForOverflow(overflowReport, operand1, operand2, operatr)
    }
}
