//
//  NodeManager.swift
//  TIS-100
//
//  Created by Brad Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class NodeManager: NSObject {
    var nodes: [NodeView]?
    var threads: [NSThread]
    
    override init() {
        self.threads = [NSThread]()
        super.init()
    }
    
	func execute(nodes: [NodeView]) {
		self.nodes = nodes
        threads = [NSThread]()
        for node in nodes {
            let thread = NSThread(target: self, selector: "runNode:", object: node)
            self.threads.append(thread)
        }
        
        for thread in threads {
            thread.start()
        }
    }
	
	func sourcePortToDestPort(srcPort: Int) -> Int {
		switch srcPort {
		case 0:
			return 2
		case 1:
			return 3
		case 2:
			return 0
		case 3:
			return 1
		default:
			return 0
		}
	}
	
	func destNodeIdxForPort(nodeIdx: Int, destPort: Int) -> Int {
		switch destPort {
		case 0:
			return nodeIdx - 3
		case 1:
			return nodeIdx + 1
		case 2:
			return nodeIdx + 3
		case 3:
			return nodeIdx - 1
		default:
			// TODO: Error
			return nodeIdx
		}
	}
	
	// 0 = up, 1 = right, 2 = down, 3 = left
	func writeToPort(sourceNode: BasicNode, dest: Int) {
		let destIdx = destNodeIdxForPort(sourceNode.nodeId, destPort: dest)
		
		if let destNode = self.nodes?[destIdx] {
			let destPort = sourcePortToDestPort(dest)
			destNode.node.ports[destPort] = sourceNode.ports[dest]
		} else {
			print("Bad node")
		}
	}
	
	func readFromPort(sourcNode: BasicNode, dest: Int) -> Int? {
		let destIdx = destNodeIdxForPort(sourcNode.nodeId, destPort: dest)
		
		if let destNode = self.nodes?[destIdx] {
			let sourcePort = sourcePortToDestPort(dest)
			if let portValue = destNode.node.ports[sourcePort] {
				destNode.node.ports[sourcePort] = nil
				return portValue
			} else {
				return nil
			}
		}
		
		return nil
	}
	
    func runNode(node: NodeView) {
		let parser = TISParser()
		node.node.runProgram(parser.parse(node.sourceView.text))
		node.node.dumpRegs()
		let idx = self.nodes!.indexOf(node)
		threads[idx!].cancel()
    }
}
