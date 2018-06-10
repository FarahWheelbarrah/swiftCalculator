//  Modulus.swift
//  calc

/* Encapsulates functions of the modulus operation */

import Foundation

class Modulus : Operation {
    
    override func evaluate(_ operand1: Operand, _ operand2: Operand) throws -> Operand {
        try OperationErrorChecker.divisionByZero(operand2)
        return Operand(operand: operand1.operand % operand2.operand)
    }
}
