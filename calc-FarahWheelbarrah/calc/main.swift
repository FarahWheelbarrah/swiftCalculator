//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

var inputExpression = Expression(expressionArgs: args)

do {
    try inputExpression.processInputAndEvaluateExpression()
    print(inputExpression.answer)
} catch let error as ExpressionError {
    print(Expression.errorMessage(of: error))
    exit(1)
}
