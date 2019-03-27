//
//  calculator.swift
//  calc
//
//  Created by Charlie on 27/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

func processArguments(passedArguments: Array<String>) -> Array<CalcChunk>? {
	
	/*	### processArguments ###
	
		Description -> processArguments takes an array of String arguments and performs several safety checks on them to ensure that the input is safe. After these checks, processArguments converts the String array into an array of CalcChunk objects ready for calculation.
	
	*/
	
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
	
	guard let finalValue = passedArguments.last, let finalChunk = CalcChunk(inputValue: finalValue) else {
		return nil
	}
	
	safeChunks.append(finalChunk)
	
	return safeChunks
	
}

func performCalculations(passedChunks: Array<CalcChunk>, validOperators: Array<CalcOperator>) -> Array<CalcChunk> {
	
	/*	### performCalculations ###
	
		Description -> performCalculations handles the main calculation operations. The function takes an input of the operations that it is permitted to evalutate, which allows for a first pass processing .div, .mul & .mod operations and then a second pass for .add & .sub, respecting valid order of operations. The funtion also takes input of a CalcChunk array that it needs to evaluate.
	
		Output -> performCalculations appends any CalcChunk objects that do not contain a valid operator to a finalChunks array. After two passes, this leaves only a single CalcChunk object with a .none operator. Te value of this final chunk is the final result of the calculation.
	
	*/
	
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
