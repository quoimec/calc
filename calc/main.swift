//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

func calc(passedArguments: Array<String>) -> Int? {
	
	var mutableArguments = passedArguments
	mutableArguments.removeFirst()
	
	if mutableArguments.count == 0 {
		return nil
	}
	
	mutableArguments.removeLast()

	if mutableArguments.count % 2 != 0 {
		return nil
	}
	
	var safeChunks = Array<CalcChunk>()
	
	for eachIndex in 0 ..< mutableArguments.count / 2 {
	
		let scaledIndex = eachIndex * 2
	
		guard let validChunk = CalcChunk(inputValue: mutableArguments[scaledIndex], inputOperator: mutableArguments[scaledIndex + 1]) else {
			return nil
		}
		
		safeChunks.append(validChunk)
	
	}
	
	guard let finalChunk = CalcChunk(inputValue: passedArguments.last!) else {
		return nil
	}
	
	safeChunks.append(finalChunk)
	
	let firstOperations: Array<CalcOperator> = [.mul, .div, .mod]
	let secondOperations: Array<CalcOperator> = [.add, .sub]
	
	func performCalculations(passedChunks: Array<CalcChunk>, validOperators: Array<CalcOperator>) -> Array<CalcChunk> {
		
		var mutableChunks = passedChunks
		var finalChunks = Array<CalcChunk>()
		
		for eachIndex in 0 ..< mutableChunks.count {
		
			if !validOperators.contains(mutableChunks[eachIndex].calcOperator) {
				finalChunks.append(mutableChunks[eachIndex])
				continue
			}
			
			mutableChunks[eachIndex + 1].calcValue = mutableChunks[eachIndex].evaluateChunk(nextValue: mutableChunks[eachIndex + 1].calcValue)
		
		}
		
		return finalChunks
	
	}
	
	safeChunks = performCalculations(passedChunks: safeChunks, validOperators: firstOperations)
	safeChunks = performCalculations(passedChunks: safeChunks, validOperators: secondOperations)
	
	return safeChunks[0].calcValue
	
}

enum CalcOperator {
	case add, sub, mul, div, mod, none
}

struct CalcChunk {

	var calcValue: Int
	var calcOperator: CalcOperator
	
	init?(inputValue: String) {
		
		guard let calcValue = Int(inputValue) else {
			return nil
		}
		
		self.calcValue = calcValue
		self.calcOperator = .none
		
	}
	
	init?(inputValue: String, inputOperator: String) {
	
		guard let calcValue = Int(inputValue) else {
			return nil
		}
		
		self.calcValue = calcValue
		
		switch inputOperator {
		
			case "+":
			self.calcOperator = .add
		
			case "-":
			self.calcOperator = .sub
		
			case "x":
			self.calcOperator = .mul
		
			case "/":
			self.calcOperator = .div
		
			case "%":
			self.calcOperator = .mod
		
			default:
			return nil
		
		}
		
	}

	func evaluateChunk(nextValue: Int) -> Int {
	
		switch self.calcOperator {
		
			case .add:
			return calcValue + nextValue
			
			case .sub:
			return calcValue - nextValue
			
			case .mul:
			return Int(calcValue * nextValue)
			
			case .div:
			return Int(calcValue / nextValue)
			
			case .mod:
			return calcValue % nextValue
			
			case .none:
			return calcValue
			
		}
	
	}

}

if let calculatedValue = calc(passedArguments: ProcessInfo.processInfo.arguments) {
	print(calculatedValue)
} else {
	exit(1)
}
