//  Operation.swift
//  calc

/* Encapsulates functions of arbitrary mathematical operations */

import Foundation

class Operation {
    
    func evaluate(_ operand1: Operand, _ operand2: Operand) throws -> Operand {
        // an arbitrary operator does not perform an operation
        preconditionFailure("This method must be overriden")
    }
}
