//
//  TISParser.swift
//  TIS-100
//
//  Created by Bradley Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class TISParser: Parser {
	
	func parseToken() -> String {
		return consumeWhile({(ch: Character) -> Bool in
			return !self.isWhiteSpace(ch)
		})
	}
	
	func parseInput() -> [InstructionSet] {
		var tokens = [InstructionSet]()
		
		while !self.eof() {
		let token = parseToken()
		
			switch token {
			case "MOV":
				self.consumeWhitespace()
				let src = consumeWhile({(ch: Character) -> Bool in
					return (ch != "," && !self.isWhiteSpace(ch))
				})
				if (self.nextChar() == ",") {
					self.consumeChar()
					self.consumeWhitespace()
				}
				let dest = parseToken()
				tokens.append(.Mov(src, dest))
			case "NOP":
				tokens.append(.Nop)
			case "SWP":
				tokens.append(.Swp)
			case "SAV":
				tokens.append(.Sav)
			case "ADD":
                self.consumeWhitespace()
				let src = parseToken()
				tokens.append(.Add(src))
			case "SUB":
                self.consumeWhitespace()
				let src = parseToken()
				tokens.append(.Sub(src))
			case "NEG":
				tokens.append(.Neg)
			case "JMP":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jmp(label))
			case "JEZ":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jez(label))
			case "JNZ":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jnz(label))
			case "JGZ":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jgz(label))
			case "JLZ":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jlz(label))
			case "JRO":
                self.consumeWhitespace()
				let label = parseToken()
				tokens.append(.Jro(label))
			default:
				let len = token.characters.count
				let idx = len - 1
				if token.substringFromIndex(advance(token.startIndex, idx)) == ":" {
					let label = token.substringToIndex(advance(token.startIndex, idx))
					tokens.append(.Label(label))
				}
			}
			
			self.consumeWhitespace()
		}
		
		return tokens
	}
	
	func parse(input: String) -> [InstructionSet] {
		self.input = input
		self.pos = 0
		
		return self.parseInput()
	}
}
