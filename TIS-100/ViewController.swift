//
//  ViewController.swift
//  TIS-100
//
//  Created by Bradley Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

	@IBOutlet var sourceView: UITextView!
	@IBOutlet var accLbl: UILabel!
	@IBOutlet var bakLbl: UILabel!
	
	let node = BasicNode(withId: 0)
    
    var manager: NodeManager?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        let runButton = UIButton(frame: CGRectMake(10, 15, 100, 25))
        runButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        runButton.backgroundColor = UIColor.whiteColor()
        runButton.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 15.0)
        runButton.setTitle("RUN", forState: .Normal)
        runButton.addTarget(self, action: "runProgram:", forControlEvents: .TouchUpInside)
        self.view.addSubview(runButton)
        
		let nv = NodeView(frame: CGRectMake(50, 50, 250, 280), nodeId: 0)
        let nv1 = NodeView(frame: CGRectMake(nv.frame.origin.x + 325, 50, 250, 280), nodeId: 1)
        let nv2 = NodeView(frame: CGRectMake(nv1.frame.origin.x + 325, 50, 250, 280), nodeId: 2)
        self.view.addSubview(nv)
        self.view.addSubview(nv1)
        self.view.addSubview(nv2)
		
        manager = NodeManager(nodes: [nv, nv1, nv2])
	}
	
	@IBAction func runProgram(sender: AnyObject) {
		manager?.execute()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		
		let nsTextViewText = textView.text as NSString
		textView.text = nsTextViewText.stringByReplacingCharactersInRange(range, withString: text.uppercaseString) as String
		
		return false
	}
}

