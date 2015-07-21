//
//  InstructionSet.swift
//  TIS-100
//
//  Created by Bradley Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import Foundation

enum InstructionSet {
	case Label(String)
	case Nop
	case Mov(String, String)
	case Swp
	case Sav
	case Add(String)
	case Sub(String)
	case Neg
	case Jmp(String)
	case Jez(String)
	case Jnz(String)
	case Jgz(String)
	case Jlz(String)
	case Jro(String)
}
