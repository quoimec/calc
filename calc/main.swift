//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

guard let processedArguments = processArguments(passedArguments: ProcessInfo.processInfo.arguments) else {
	exit(1)
}

let calculatedValue = performCalculations(passedChunks: performCalculations(passedChunks: processedArguments, validOperators: [.mul, .div, .mod]), validOperators: [.add, .sub])

print(calculatedValue[0].calcValue)
