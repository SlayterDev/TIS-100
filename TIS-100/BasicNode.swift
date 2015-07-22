//
//  BasicNode.swift
//  TIS-100
//
//  Created by Bradley Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import Foundation

protocol BasicNodeDelegate {
    func didUpdateRegisters()
}

class BasicNode: NSObject {
	var ACC: Int
	var BAK: Int
	let NIL = 0
	var ports: [Int?] // up = 0, right = 1, down = 2, left = 3
	var idleLvl: Float
	
	var ip: Int
	var lables: NSMutableDictionary
	
	var nodeId: Int
    
    var delegate: BasicNodeDelegate?
	var manager: NodeManager
	
	let regNames = ["UP", "RIGHT", "DOWN", "LEFT", "ACC", "BAK", "NIL"]
	
	init(withId id: Int, manager: NodeManager) {
		self.nodeId = id
		self.ACC = 0
		self.BAK = 0
		self.idleLvl = 0.0
		self.ip = 0
		self.ports = [Int?](count: 4, repeatedValue: nil)
		self.lables = NSMutableDictionary()
		self.manager = manager
	}
	
	func getPortVal(port: String) -> Int {
		// TODO: Blocking/Removing value from port
		let idx = regNames.indexOf(port)
		
		while true {
			if let recvVal = self.manager.readFromPort(self, dest: idx!) {
				ports[idx!] = recvVal
				break
			}
		}
		
		let retVal = ports[idx!]!
		ports[idx!] = nil
		return retVal
	}
	
	func writeToPort(port: String, val: Int) {
		// TODO: Blocking
		let idx = regNames.indexOf(port)!
		ports[idx] = val
		
		self.manager.writeToPort(self, dest: idx)
		while ports[idx] != nil { }
	}
	
	func executeInstruction(inst: InstructionSet) {
		switch inst {
		case .Label(let str):
			lables.setValue(ip, forKey: str)
		case .Nop:
			ACC += 0
		case .Mov(let src, let dest):
			var srcVal: Int
			if regNames.contains(src) {
				switch src {
				case "ACC":
					srcVal = ACC
				case "NIL":
					srcVal = 0
				case "BAK":
					// TODO: ERROR
					srcVal = 0
					break
				default:
					srcVal = getPortVal(src)
				}
			} else {
				srcVal = Int(src)!
			}
			
			switch dest {
			case "ACC":
				ACC = srcVal
			case "NIL":
				break
			case "BAK":
				//TODO: Error
				break
			default:
				writeToPort(dest, val: srcVal)
			}
		case .Swp:
			let temp = ACC
			ACC = BAK
			BAK = temp
		case .Sav:
			BAK = ACC
		case .Add(let src):
			if regNames.contains(src) {
				switch src {
				case "ACC":
					ACC += ACC
				case "NIL":
					ACC += 0
				case "BAK":
					//TODO: Error
					break
				default:
					ACC += getPortVal(src)
				}
			} else {
				ACC += Int(src)!
			}
		case .Sub(let src):
			if regNames.contains(src) {
				switch src {
				case "ACC":
					ACC -= ACC
				case "NIL":
					ACC -= 0
				case "BAK":
					//TODO: Error
					break
				default:
					ACC -= getPortVal(src)
				}
			} else {
				ACC -= Int(src)!
			}
		case .Neg:
			ACC *= -1
		case .Jmp(let str):
			ip = Int(lables.valueForKey(str)!.intValue)
		case .Jez(let str):
			if ACC == 0 {
				ip = Int(lables.valueForKey(str)!.intValue)
			}
		case .Jnz(let str):
			if ACC != 0 {
				ip = Int(lables.valueForKey(str)!.intValue)
			}
		case .Jgz(let str):
			if ACC > 0 {
				ip = Int(lables.valueForKey(str)!.intValue)
			}
		case .Jlz(let str):
			if ACC < 0 {
				ip = Int(lables.valueForKey(str)!.intValue)
			}
		case .Jro(let str):
			ip += Int(str)!
		}
	}
	
	func clearCPU() {
		ip = 0
		ACC = 0
		BAK = 0
		idleLvl = 0.0
		ports = [Int?](count: 4, repeatedValue: nil)
	}
    
    func updateUI() {
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate?.didUpdateRegisters()
        })
    }
	
	func runProgram(instructions: [InstructionSet]) {
		clearCPU()
		for ip = 0; ip < instructions.count; ip++ {
			executeInstruction(instructions[ip])
            updateUI()
		}
	}
	
	func dumpRegs() {
		print("Node \(self.nodeId): ACC: \(ACC) BAK: \(BAK)")
	}
}
