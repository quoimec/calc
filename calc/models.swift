//
//  Models.swift
//  calc
//
//  Created by Charlie on 27/3/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

enum CalcOperator {
	
	/*	### CalcOperator ###
	
		Description -> CalcOperator contains the currently supported operations by this program. The operator also contains a "none" for the final odd value of the input string where there is no operator to include in the CalcChunk object.
	
	*/

	case add, sub, mul, div, mod, none
}

struct CalcChunk {

	/*	### CalcChunk ###
	
		Description -> CalcChunk is the core structure of this program, it allows the values to be "chunked" down into smaller components containing a both a value and an operator
	
		Initialisation -> CalcChunk has two initialisers, one for normal value/operator input and another for when there is no operator to input i.e: the last value in the input string array. Both initialisers are failable to catch bad input.
	
		Evaluation -> CalcChunk contains a single evaluation function to process itself. More details are listed below.
	
	*/

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
	
		/*	### evaluateChunk ###
	
			Description -> evaluateChunk is the brains of the calculator, it takes itself as a chunk and the value from the next chunk and performs the required operation on the two values.
		
			Output -> evaluateChunk outputs a single integer that should be used to replace the value of the next CalcChunk object. Once evaluateChunk has been called, the chunk itself is considered used and spent.
		
		*/
	
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
