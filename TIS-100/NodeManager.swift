//
//  NodeManager.swift
//  TIS-100
//
//  Created by Brad Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class NodeManager: NSObject {
    var nodes: [NodeView]
    var threads: [NSThread]
    
    init(nodes: [NodeView]) {
        self.nodes = nodes
        self.threads = [NSThread]()
        super.init()
    }
    
    func execute() {
        threads = [NSThread]()
        for node in nodes {
            let thread = NSThread(target: self, selector: "runNode:", object: node)
            self.threads.append(thread)
        }
        
        for thread in threads {
            thread.start()
        }
    }
    
    func runNode(node: NodeView) {
        //if let node = anObject as? NodeView {
            let parser = TISParser()
            node.node.runProgram(parser.parse(node.sourceView.text))
            node.node.dumpRegs()
            let idx = self.nodes.indexOf(node)
            threads[idx!].cancel()
        //}
    }
}
