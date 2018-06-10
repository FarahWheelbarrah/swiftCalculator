//  ExpressionTerm.swift
//  calc

/* Models an arbitrary term in a mathematical expression.
 Is either an operand or an operator */

import Foundation

class ExpressionTerm {

    func expressionTerm() -> String {
        // each ExpressionTerm will handle returning its own data
        preconditionFailure("This method must be overriden")
    }
}
