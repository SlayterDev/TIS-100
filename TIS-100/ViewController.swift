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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		sourceView.layer.borderWidth = 10
		sourceView.layer.borderColor = UIColor.whiteColor().CGColor
		sourceView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
		sourceView.delegate = self
		
	}
	
	@IBAction func runProgram(sender: AnyObject) {
		let parser = TISParser()
		node.runProgram(parser.parse(sourceView.text))
		self.accLbl.text = "ACC: " + String(node.ACC)
		self.bakLbl.text = "BAK: " + String(node.BAK)
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

