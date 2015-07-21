//
//  Parser.swift
//  WebEngine
//
//  Created by Bradley Slayter on 6/9/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class Parser: NSObject {
	var pos: Int = 0
	var input: String?
	
	// Peek at the next character without advancing pos
	func nextChar() -> Character {
		return (self.input?[advance((self.input?.startIndex)!, self.pos)])!
	}
	
	// Check if input starts with given string
	func startsWith(s: String) -> Bool {
		let subString = self.input?.substringFromIndex(advance(self.input!.startIndex, self.pos))
		
		return subString!.hasPrefix(s)
	}
	
	// Check for the end of file
	func eof() -> Bool {
		return (self.pos >= self.input?.characters.count)
	}
	
	// Return current char and advance pos
	func consumeChar() -> Character {
		let ch = self.input?[advance((self.input?.startIndex)!, self.pos)]
		
		self.pos++
		
		return ch!
	}
	
	// Consume chars until `test` returns false
	func consumeWhile(test: (ch: Character) -> Bool) -> String {
		var result = ""
		
		while !self.eof() && test(ch: self.nextChar()) {
			result += String(self.consumeChar())
		}
		
		return result
	}
	
	// Function to check if a Character is white space
	func isWhiteSpace(ch: Character) -> Bool {
		let whiteSpace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
		
		let range = String(ch).rangeOfCharacterFromSet(whiteSpace)
		
		return (range != nil)
	}
	
	// Consume while there is white space
	func consumeWhitespace() {
		self.consumeWhile(isWhiteSpace)
	}
}
